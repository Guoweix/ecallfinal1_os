#include "Driver/Memlayout.hpp"
#include "Driver/Virtio.hpp"
#include "Library/KoutSingle.hpp"
#include "Memory/pmm.hpp"
#include "Synchronize/Synchronize.hpp"
#include "Trap/Interrupt.hpp"
#include "Types.hpp"
#include <Driver/Plic.hpp>
#include <Driver/VirtioDisk.hpp>
#include <Library/Kstring.hpp>
#include <Process/ParseELF.hpp>

#define R(r) ((volatile Uint32*)(VIRTIO0_V + (r)))
#define sectorSize 512

void VirtioDisk::init()
{

    waitDisk = new Semaphore(1);
    Uint32 status = 0;

    if (*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 || *R(VIRTIO_MMIO_VERSION) != 1 || *R(VIRTIO_MMIO_DEVICE_ID) != 2 || *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551) {
        //    panic("could not find virtio disk");
        kout[Fault] << "Cannot find VirtIO Disk!" << endl;
    }

    status |= VIRTIO_CONFIG_S_ACKNOWLEDGE;
    *R(VIRTIO_MMIO_STATUS) = status;

    status |= VIRTIO_CONFIG_S_DRIVER;
    *R(VIRTIO_MMIO_STATUS) = status;

    // negotiate features
    Uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    features &= ~(1 << VIRTIO_BLK_F_RO);
    features &= ~(1 << VIRTIO_BLK_F_SCSI);
    features &= ~(1 << VIRTIO_BLK_F_CONFIG_WCE);
    features &= ~(1 << VIRTIO_BLK_F_MQ);
    features &= ~(1 << VIRTIO_F_ANY_LAYOUT);
    features &= ~(1 << VIRTIO_RING_F_EVENT_IDX);
    features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;

    // tell device that feature negotiation is complete.
    status |= VIRTIO_CONFIG_S_FEATURES_OK;
    *R(VIRTIO_MMIO_STATUS) = status;

    // tell device we're completely ready.
    status |= VIRTIO_CONFIG_S_DRIVER_OK;
    *R(VIRTIO_MMIO_STATUS) = status;

    *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PAGESIZE;

    // initialize queue 0.
    *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    Uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    if (max == 0)
        //    panic("virtio disk has no queue 0");
        kout[Fault] << "VirtIO Disk has no queue 0!" << endl;
    if (max < NUM)
        kout[Fault] << "VirtIO Disk max queue too short!" << endl;
    *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    memset(pages, 0, sizeof(pages));
    *R(VIRTIO_MMIO_QUEUE_PFN) = ((Uint64)pages - 0xffffffff00000000) >> 12;

    // kout[Debug] << (void*)this << endl;

    desc = (VRingDesc*)pages;
    avail = (VRingAvail*)((char*)desc + NUM * sizeof(VRingDesc));
    used = (VRingUsed*)(pages + PAGESIZE);
    used_event = (Uint16*)((char*)avail + (NUM + 3) * sizeof(Uint16));
    avail_event = (Uint16*)((char*)used + (NUM + 3) * sizeof(Uint16));

    for (int i = 0; i < NUM; i++)
        free[i] = 1;

    // kout<<DataWithSize((void *)VIRTIO0_V,100)<<endl;
}

int VirtioDisk::alloc_desc()
{
    for (int i = 0; i < NUM; i++) {
        if (free[i]) {
            free[i] = 0;
            return i;
        }
    }
    return -1;
}
void VirtioDisk::free_desc(int i)
{
    if (i >= NUM)
        kout[Fault] << "free_desc case 1" << endl;
    if (free[i])
        kout[Fault] << "free_desc case 2" << endl;
    desc[i].addr = 0;
    free[i] = 1;
}
void VirtioDisk::free_chain(int i)
{
    while (1) {
        free_desc(i);
        if (desc[i].flags & VRING_DESC_F_NEXT)
            i = desc[i].next;
        else
            break;
    }
}
int VirtioDisk::alloc3_desc(int* idx)
{
    for (int i = 0; i < 3; i++) {
        idx[i] = alloc_desc();
        if (idx[i] < 0) {
            for (int j = 0; j < i; j++)
                free_desc(idx[j]);
            return -1;
        }
    }
    return 0;
}

static VirtioBlkOuthdr buf0;

bool f;

void VirtioDisk::disk_rw(Uint8* buf, Uint64 sector, bool write)
{

    ASSERTEX((Uint64)buf > 0xffffffff00000000, "buf must be high_address");
    bool a;
    IntrSave(a);
    intr = false;
    // memset(pages, 0, PAGESIZE*2);
    // for (int i; i<8; i++) {
    //     free[i]=1;
    // }
    // kout << DataWithSizeUnited(pages, 64, 32);
    // kout << DataWithSizeUnited(&pages[4096], 64, 32);
    int idx[3]; // 用来传递queue的通配符,下标

    // kout[Debug] << "!!!!!0!!!!!" << endl;

    while (1) {
        if (alloc3_desc(idx) == 0) // 链表中分配3个通配符号
        {
            break;
        }
    }

    // kout << idx[0] << idx[1] << idx[2] << endl;
    // kout[Debug] << "!!!!!1!!!!!" << endl;
    if (write)
        buf0.type = VIRTIO_BLK_T_OUT;
    else
        buf0.type = VIRTIO_BLK_T_IN;
    // kout<<DataWithSizeUnited(avail,128,32);

    buf0.reserved = 0;
    buf0.sector = sector;

    // kout[Debug] << "!!!!!2!!!!!" << endl;

    // 第一个通配符传递buf0,缓冲区的长度和地址
    desc[idx[0]].addr = (Uint64)&buf0 - 0xffffffff00000000;
    desc[idx[0]].len = sizeof(buf0);
    desc[idx[0]].flags = VRING_DESC_F_NEXT;
    desc[idx[0]].next = idx[1];

    // 第二个通配符传递缓冲地址
    desc[idx[1]].addr = (Uint64)buf - 0xffffffff00000000;
    desc[idx[1]].len = sectorSize;
    if (write)
        desc[idx[1]].flags = 0;
    else
        desc[idx[1]].flags = VRING_DESC_F_WRITE;
    desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    desc[idx[1]].next = idx[2];

    // 第三个通配符用于读检查
    info.status = 0;

    desc[idx[2]].addr = (Uint64)(&info.status) - 0xffffffff00000000;
    desc[idx[2]].len = sizeof(info.status);
    desc[idx[2]].flags = VRING_DESC_F_WRITE;
    desc[idx[2]].next = 0;

    info.flag = 0;
    info.buf = buf;
    // avail[2 + (avail[1].index % NUM)]. = idx[0];
    // Uint16 * t=(Uint16 *)avail;
    avail->ring[avail->index % NUM] = idx[0];
    // *(t+2+(avail->index%NUM))=idx[0];

    __sync_synchronize();
    avail->index = avail->index + 1;

    // kout[Debug] << "!!!!!3!!!!!" << endl;
    last_used_idx = used->id;
    // kout[Debug] << used->id << endl;
    // kout[Debug] << last_used_idx << endl;

    info.flag = 1;

    // InterruptEnable();
    *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // 通知QEMU

    // waitDisk->wait();
    while (last_used_idx == used->id) { // 轮询操作,等待中断
        // f=1;
        // while (f) {
    }

    // kout<<"wait"<<endl;
    // kout[Debug] << "!!!!!4!!!!!" << endl;
    // InterruptDisable();

    free_chain(idx[0]);
    IntrRestore(a);
}

void VirtioDisk::virtio_disk_intr()
{
    // f=0;
    // waitDisk->signal();
    // kout << "intr" << endl;
    // kout[Debug] << used->id << endl;
    // kout[Debug] << last_used_idx << endl;
    *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3; // 确认受到响应
}

// void VirtioDisk::virtio_disk_intr()
// {
//     //  acquire(&disk.vdisk_lock);
//     //   disk.lock.Lock();
//     while ((used_idx % NUM) != (used->id % NUM)) {
//         int id = used->elems[used_idx].id;

//         // kout[Debug]<<"virtio_disk_intr "<<disk.info[id].sem->Value()<<" "<<id<<endl;
//         int i;
//         for (i = 0; info.status != 0 && i <= 10; ++i)
//             //      panic("virtio_disk_intr status");
//             if (i >= 100)
//                 kout[Fault] << "virtio_disk_intr status " << (int)info.status << endl;

//         //    wakeup(disk.info[id].b);
//         //	kout[Debug]<<POS_PM.Current()->GetPID()<<" Signal "<<disk.info[id].sem<<endl;
//         // info[id].sem->Signal();
//         used_idx = (used_idx + 1) % NUM;
//     }
//     *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;

//     //  release(&disk.vdisk_lock);
//     //   disk.lock.Unlock();
// }

VirtioDisk VDisk;

bool DISK::DiskInit()
{
    // kout[yellow] << "Disk init..." << endl;
    // kout[yellow] << "plic init..." << endl;
    // kout[red]<<Hex(f())<<endl;
    diskBuf = (void*)kmalloc(0x1000);
    plicinit();

    kout[Info] << "plic init hart..." << endl;
    plicinithart();
    kout[Info] << "VirtIO disk init..." << endl;

    VDisk.init();

    kout[Info] << "Disk init K" << endl;
    return true;
}

bool DISK::readSector(unsigned long long LBA, Sector* sec, int cnt)
{
    VDisk.waitDisk->wait();
    // bool f;
    // IntrSave(f);
    if ((Uint64)sec < 0xffffffff00000000) {
        for (int i = 0; i < cnt; ++i) {
            VDisk.disk_rw((Uint8*)(diskBuf), LBA + i, 0);
            memcpy((void*)(sec + i), (const char*)diskBuf, sectorSize);
        }
    } else {
        for (int i = 0; i < cnt; ++i) {
            // kout[Info]<<"read blk "<<LBA+i<<endl;
            VDisk.disk_rw((Uint8*)(sec + i), LBA + i, 0);
        }
    }
    VDisk.waitDisk->signal();
    // IntrRestore(f);
    return true;
}

bool DISK::writeSector(unsigned long long LBA, const Sector* sec, int cnt)
{

    VDisk.waitDisk->wait();
    if ((Uint64)sec < 0xffffffff00000000) {
        for (int i = 0; i < cnt; ++i) {
            memcpy(diskBuf, (const char*)(sec + i), sectorSize);
            VDisk.disk_rw((Uint8*)(diskBuf), LBA + i, 1);
        }
    } else {
        for (int i = 0; i < cnt; ++i) {
            VDisk.disk_rw((Uint8*)(sec + i), LBA + i, 1);
        }
    }

    VDisk.waitDisk->signal();

    return true;
}

bool DISK::DiskInterruptSolve()
{
    // VDisk.waitDisk->wait();
    VDisk.virtio_disk_intr();
    return true;
}

DISK Disk;