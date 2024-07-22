#ifndef __VIRTIO_DISK_HPP__
#define __VIRTIO_DISK_HPP__

#include "Types.hpp"
#include <Driver/Memlayout.hpp>
#include <Driver/Virtio.hpp>
#include <Library/KoutSingle.hpp>
#include <Library/Kstring.hpp>
#include <Memory/pmm.hpp>
#include <Synchronize/Synchronize.hpp>

struct AddrSize {
  Uint64  vp_addr;           /* 物理地址 */
  Uint32 vp_size;               /* 大小 */
  Uint32 vp_flag;   /*标记，如读，写*/
};

class Semaphore;
struct VirtioBlkOuthdr {
    Uint32 type;
    Uint32 reserved;
    Uint64 sector;
};

constexpr int sectorSize = 512;

struct Sector {
    Uint8 data[sectorSize];

    inline Uint8& operator[](unsigned pos)
    {
        return data[pos];
    }

    inline const Uint8& operator[](int i) const
    {
        return data[i];
    }
};

struct VirtioDisk {

    char pages[2 * PAGESIZE];
    VRingDesc* desc;

    VRingAvail* avail;
    VRingUsed* used;

    Uint16 used_last_id;
    Uint16 * avail_event;
    Uint16 * used_event;

    bool intr;
    char free[NUM];
    // Uint16 used_idx;

    Semaphore * waitDisk;
    int  last_used_idx;

    
    struct
    {
        Uint8* buf;
        int flag;
        char status;
    } info;

    void init();
    int alloc_desc();
    void free_desc(int i);
    void free_chain(int i);
    int alloc3_desc(int* idx);
    void disk_rw(Uint8* buf, Uint64 sector, bool write);
    void virtio_disk_intr();

} __attribute__((aligned(PAGESIZE)));

struct DISK {
    void * diskBuf;
    bool DiskInit();
    bool readSector(Uint64 LBA, Sector* sec, int cnt = 1);
    bool writeSector(Uint64 LBA, const Sector* sec, int cnt = 1);
    bool DiskInterruptSolve();
};

extern VirtioDisk VDisk;
extern DISK Disk;

#endif