## 硬盘驱动部分
硬盘驱动主要是与Virtio进行通信
重点则是要搞清楚协议的设定，Virtio不只是一种设备，而是支持许多设备，硬盘主要是使用Virtio_blk协议。
本协议主要在于Vring的管理，宿主机和客户OS共同维护设备环。分为四个部分
- 初始化
按照文档将对应内存中的值填好即可
客户OS要注意分配Vring所在位置，同时管理avail部分
- 客户OS操作Vring环
分配Vring上三个Desc块，操作完成之后，修改avail部分的可用值，并对特定内存写入通知宿主机
- 宿主机读取环后执行操作，并通知客户OS
宿主机读取avail后读取Desc块执行相应操作，修改used部分的值，并通过提前约定的中断值通知客户OS
- 客户OS在接受到消息后再次确认


可以看出宿主OS可以使用轮询used或者接收中断的方式相应操作，由于实现驱动的时候信号量测试还不完全，于是使用了轮询的方式实现查询
```cpp
    //....
    InterruptEnable();
    *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; //通知QEMU 

    while (last_used_idx==used->id) {//轮询操作,等待中断
    }
    
    // kout[Debug] << "!!!!!4!!!!!" << endl;
    InterruptDisable();

    free_chain(idx[0]);
    IntrRestore(a);
}

void VirtioDisk::virtio_disk_intr()
{
    // kout << "intr" << endl;
    // kout[Debug] << used->id << endl;
    // kout[Debug] << last_used_idx << endl;
    *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;//确认受到响应

}


```

本操作系统使用轮询+中断的方式实现，中断用于返回确认值。由于时间紧张，将来会改成信号量管理
<p align="right">By:郭伟鑫</p>