#ifndef __VIRTIO_HPP__
#define __VIRTIO_HPP__

#include <Types.hpp>
#define VIRTIO_MMIO_MAGIC_VALUE 0x000 // 0x74726976
#define VIRTIO_MMIO_VERSION 0x004     // version; 1 is legacy
#define VIRTIO_MMIO_DEVICE_ID 0x008   // device type; 1 is net, 2 is disk
#define VIRTIO_MMIO_VENDOR_ID 0x00c   // 0x554d4551
#define VIRTIO_MMIO_DEVICE_FEATURES 0x010
#define VIRTIO_MMIO_DRIVER_FEATURES 0x020
#define VIRTIO_MMIO_GUEST_PAGE_SIZE 0x028  // page size for PFN, write-only
#define VIRTIO_MMIO_QUEUE_SEL 0x030        // select queue, write-only
#define VIRTIO_MMIO_QUEUE_NUM_MAX 0x034    // max size of current queue, read-only
#define VIRTIO_MMIO_QUEUE_NUM 0x038        // size of current queue, write-only
#define VIRTIO_MMIO_QUEUE_ALIGN 0x03c      // used ring alignment, write-only
#define VIRTIO_MMIO_QUEUE_PFN 0x040        // physical page number for queue, read/write
#define VIRTIO_MMIO_QUEUE_READY 0x044      // ready bit
#define VIRTIO_MMIO_QUEUE_NOTIFY 0x050     // write-only
#define VIRTIO_MMIO_INTERRUPT_STATUS 0x060 // read-only
#define VIRTIO_MMIO_INTERRUPT_ACK 0x064    // write-only
#define VIRTIO_MMIO_STATUS 0x070           // read/write

// status register bits, from qemu virtio_config.h
#define VIRTIO_CONFIG_S_ACKNOWLEDGE 1
#define VIRTIO_CONFIG_S_DRIVER 2
#define VIRTIO_CONFIG_S_DRIVER_OK 4
#define VIRTIO_CONFIG_S_FEATURES_OK 8

// device feature bits
#define VIRTIO_BLK_F_RO 5          /* Disk is read-only */
#define VIRTIO_BLK_F_SCSI 7        /* Supports scsi command passthru */
#define VIRTIO_BLK_F_CONFIG_WCE 11 /* Writeback mode available in config */
#define VIRTIO_BLK_F_MQ 12         /* support more than one vq */
#define VIRTIO_F_ANY_LAYOUT 27
#define VIRTIO_RING_F_INDIRECT_DESC 28
#define VIRTIO_RING_F_EVENT_IDX 29

// for disk ops
#define VIRTIO_BLK_T_IN 0  // read the disk
#define VIRTIO_BLK_T_OUT 1 // write the disk

#define VRING_DESC_F_NEXT 1  // chained with another descriptor
#define VRING_DESC_F_WRITE 2 // device writes (vs read)

// this many virtio descriptors.
// must be a power of two.
#define NUM 8

// struct VirtioMMIO
// {

//     enum : Sint64
//     {
//         BLK_F_RO = ~(1 << VIRTIO_BLK_F_RO),
//         BLK_F_SCSI = ~(1 << VIRTIO_BLK_F_SCSI),
//         BLK_F_CONFIG_WCE = ~(1 << VIRTIO_BLK_F_CONFIG_WCE),
//         BLK_F_MQ = ~(1 << VIRTIO_BLK_F_MQ),
//         F_ANY_LAYOUT = ~(1 << VIRTIO_F_ANY_LAYOUT),
//         RING_F_INDIRECT_DESC = ~(1 << VIRTIO_RING_F_INDIRECT_DESC),
//         RING_F_EVENT_IDX = ~(1 << VIRTIO_RING_F_EVENT_IDX),

//     };



//     Uint32 magic;
//     Uint32 version;
//     Uint32 deviceID;
//     Uint32 vendorID;
//     Uint64 deviceFeatures[2];
//     Uint64 driverFeatures;
//     Uint64 guestPageSize;
//     Uint32 queueSel;
//     Uint32 queueNumMax;
//     Uint32 queueNum;
//     Uint32 queueAlign;
//     Uint32 queuePFN;
//     Uint8 queueReady[12];
//     Uint8 queueNotify[16];
//     Uint32 interruptStatus;
//     Uint64 interruptAck;
//     Uint32 _____;
//     Uint32 status;
// } __attribute__((packed));

struct VRingDesc
{
    Uint64 addr;
    Uint32 len;
    Uint16 flags;
    Uint16 next;
};

struct VRingUsedElem
{
    Uint32 id; // index of start of completed descriptor chain
    Uint32 len;
};

struct VRingAvail
{
    Uint16 flags;
    Uint16 index;
    Uint16 ring[];
};

struct VRingUsed
{
    Uint16 flags;
    Uint16 id;
    struct VRingUsedElem elems[];
};

#endif