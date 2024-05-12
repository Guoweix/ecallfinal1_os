#ifndef __VIRTIO_DISK_HPP__
#define __VIRTIO_DISK_HPP__

#include <Driver/Memlayout.hpp>
#include <Driver/Virtio.hpp>
#include <Memory/pmm.hpp>
#include <Library/KoutSingle.hpp>

struct VirtioBlkOuthdr
{
    Uint32 type;
    Uint32 reserved;
    Uint64 sector;
};

struct VirtioDisk
{

    char pages[2 * PAGESIZE];
    VRingDesc *desc;

    Uint16 *avail;
    UsedArea *used;

    char free[NUM];
    Uint16 used_idx;
    struct
    {
        Uint8 *buf;
        int flag;
        char status;
    } info[NUM];

    volatile VirtioMMIO *MMIO;
    void init();
    int alloc_desc();
    void free_desc(int i);
    void free_chain(int i);
    int alloc3_desc(int *idx);
    void disk_rw(Uint8 *buf, Uint64 sector, bool write);
    void virtio_disk_intr();
} __attribute__((aligned(PAGESIZE)));

extern VirtioDisk VDisk;

#endif