#ifndef __MEMLAYOUT_H__
#define __MEMLAYOUT_H__

#define QEMU
    #ifdef QEMU
    #define UART                0x10000000L
    #define VIRTIO0             0x10001000L
    #define CLINT               0x02000000L
    #endif
#endif
