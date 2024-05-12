#include <Driver/VirtioDisk.hpp>

// #define R(r) ((volatile Uint32 *)(VIRTIO0 + (r)))
#define sectorSize 4096;

void VirtioDisk::init()
{
    MMIO = (VirtioMMIO *)VIRTIO0;

    Uint32 status = 0;

    kout[Debug]
        << (void *)&MMIO->magic << endline
        << (void *)&MMIO->version << endline
        << (void *)&MMIO->deviceID << endline
        << (void *)&MMIO->vendorID << endline
        << (void *)&MMIO->deviceFeatures << endline
        << (void *)&MMIO->driverFeatures << endline
        << (void *)&MMIO->guestPageSize << endline
        << (void *)&MMIO->queueSel << endline
        << (void *)&MMIO->queueNumMax << endline
        << (void *)&MMIO->queueNum << endline
        << (void *)&MMIO->queueAlign << endline
        << (void *)&MMIO->queuePFN << endline
        << (void *)&MMIO->queueReady << endline
        << (void *)&MMIO->queueNotify << endline
        << (void *)&MMIO->interruptStatus << endline
        << (void *)&MMIO->interruptAck << endline
        << (void *)&MMIO->status << endl;

    if (MMIO->magic != 0x74726976 ||
        MMIO->version != 1 ||
        MMIO->deviceID != 2 ||
        MMIO->vendorID != 0x554d4551)
    {
        kout[Debug] << "Can\'t find VirtIO Disk" << endl;
    }
    status |= VIRTIO_CONFIG_S_ACKNOWLEDGE;
    MMIO->status = status;
    status |= VIRTIO_CONFIG_S_DRIVER;
    MMIO->status = status;

    Uint64 features = MMIO->deviceFeatures[0];
    features &= VirtioMMIO::BLK_F_RO;
    features &= VirtioMMIO::BLK_F_SCSI;
    features &= VirtioMMIO::BLK_F_CONFIG_WCE;
    features &= VirtioMMIO::BLK_F_MQ;
    features &= VirtioMMIO::F_ANY_LAYOUT;
    features &= VirtioMMIO::RING_F_EVENT_IDX;
    features &= VirtioMMIO::RING_F_INDIRECT_DESC;
    MMIO->driverFeatures = features;

    status |= VIRTIO_CONFIG_S_FEATURES_OK;
    MMIO->status = status;

    status |= VIRTIO_CONFIG_S_DRIVER_OK;
    MMIO->status = status;

    MMIO->guestPageSize = PAGESIZE;
    MMIO->queueSel = 0;
    Uint32 max = MMIO->queueNumMax;
    if (max == 0)
        kout[Fault] << "VirtIO Disk has no queue 0!" << endl;
    if (max < NUM)
        kout[Fault] << "VirtIO Disk max queue too short" << endl;

    MMIO->queueNum = NUM;

    kout[Debug] << (void *)this << endl;

    desc = (VRingDesc *)pages;
    avail = (Uint16 *)((char *)desc + NUM * sizeof(VRingDesc));
    used = (UsedArea *)(pages + PAGESIZE);

    for (int i = 0; i < NUM; i++)
        free[i] = 1;
}
int VirtioDisk::alloc_desc()
{
    for (int i = 0; i < NUM; i++)
    {
        if (free[i])
        {
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
    while (1)
    {
        free_desc(i);
        if (desc[i].flags & VRING_DESC_F_NEXT)
            i = desc[i].next;
        else
            break;
    }
}
int VirtioDisk::alloc3_desc(int *idx)
{
    for (int i = 0; i < 3; i++)
    {
        idx[i] = alloc_desc();
        if (idx[i] < 0)
        {
            for (int j = 0; j < i; j++)
                free_desc(idx[j]);
            return -1;
        }
    }
    return 0;
}

void VirtioDisk::disk_rw(Uint8 *buf, Uint64 sector, bool write)
{
 
    VirtioBlkOuthdr buf0;
    int idx[3]; // 用来传递queue的通配符,下标
    kout[Debug]<<"!!!!!0!!!!!"<<endl;

    while (1)
    {
        if (alloc3_desc(idx)) // 链表中分配3个通配符号
        {
            break;
        }
    }

    kout[Debug]<<"!!!!!1!!!!!"<<endl;
    if (write)
        buf0.type = VIRTIO_BLK_T_OUT;
    else
        buf0.type = VIRTIO_BLK_T_IN;

    buf0.reserved = 0;
    buf0.sector = sector;

    kout[Debug]<<"!!!!!2!!!!!"<<endl;

    // 第一个通配符传递buf0,缓冲区的长度和地址
    desc[idx[0]].addr = (Uint64)&buf0;
    desc[idx[0]].len = sizeof(buf0);
    desc[idx[0]].flags = VRING_DESC_F_NEXT;
    desc[idx[0]].next = idx[1];

    // 第二个通配符传递缓冲地址
    desc[idx[1]].addr = (Uint64)buf;
    desc[idx[1]].len = sectorSize;
    if (write)
        desc[idx[1]].flags = 0;
    else
        desc[idx[1]].flags = VRING_DESC_F_WRITE;
    desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    desc[idx[1]].next = idx[2];

    // 第三个通配符用于读检查
    info[idx[0]].status = 0;

    desc[idx[2]].addr = (Uint64)buf;
    desc[idx[2]].len = sectorSize;
    desc[idx[2]].flags |= VRING_DESC_F_WRITE;
    desc[idx[2]].next = idx[2];

    info[idx[0]].flag = 0;
    info[idx[0]].buf = buf;

    avail[2 + (avail[1] % NUM)] = idx[0];
    avail[1] = avail[1] + 1;

    *MMIO->queueNotify=0;

    kout[Debug]<<"!!!!!3!!!!!"<<endl;

    info[idx[0]].flag = 1;
    while (info[idx[0]].flag)
    {
        
    }

    kout[Debug]<<"!!!!!4!!!!!"<<endl;
    free_chain(idx[0]);

}

void VirtioDisk::virtio_disk_intr()
{
  //  acquire(&disk.vdisk_lock);
//   disk.lock.Lock();
  while ((used_idx % NUM) != (used->id % NUM))
  {
    int id = used->elems[used_idx].id;

    // kout[Debug]<<"virtio_disk_intr "<<disk.info[id].sem->Value()<<" "<<id<<endl;
    int i;
    for (i = 0; info[id].status != 0 && i <= 10; ++i)
      //      panic("virtio_disk_intr status");
      if (i >= 100)
        kout[Fault] << "virtio_disk_intr status " << (int)info[id].status << endl;

    //    disk.info[id].b->disk = 0;   // disk is done with buf
    //    wakeup(disk.info[id].b);
    //	kout[Debug]<<POS_PM.Current()->GetPID()<<" Signal "<<disk.info[id].sem<<endl;
    // info[id].sem->Signal();

    used_idx = (used_idx + 1) % NUM;
  }
  VirtioMMIO * MMIO=(VirtioMMIO *)VIRTIO0;
  MMIO->interruptAck=MMIO->interruptStatus&0x3;
//   *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;


  //  release(&disk.vdisk_lock);
//   disk.lock.Unlock();
}

VirtioDisk VDisk;