本题目需要我们实现一个系统调用`splice`，用于将打开的文件中指定范围的数据复制到管道中，或是将数据从管道复制到文件的指定范围。其对应用户库函数的声明为：

```c
#include <unistd.h>

ssize_t splice(int fd_in, off_t *_Nullable off_in,
                      int fd_out, off_t *_Nullable off_out,
                      size_t len, unsigned int flags);
```

`splice()` 在两个文件描述符之间拷贝数据，而不涉及内核地址空间和用户地址空间之间的复制。`splice()`从文件描述符`fd_in`传输至多`len`字节的数据到文件描述符`fd_out`，其中一个文件描述符**一定是管道**，另一个一定是普通的磁盘文件。

`splice()`对于参数的要求是：

* 如果`fd_in`指的是管道，那么`off_in`必须是`NULL`。
* 如果`fd_in`不是管道，则`off_in`一定不是NULL，且`off_in`指向的位置存储了将从`fd_in`读取的偏移量。在读取过程中，`fd_in`文件描述符的偏移不改变，而是将 `*off_in` 增加成功复制的字节数。

同样地，对于`fd_out`来说：

* 如果`fd_out`指的是管道，那么`off_out`必须是`NULL`。
* 如果`fd_out`不是管道，则`off_out`一定不是NULL，且`off_out`指向的位置存储了将向`fd_out`写入的偏移量。在写入过程中，`fd_in`文件描述符的偏移不改变，而是将 `*off_out` 增加成功复制的字节数。

本系统调用的返回值为**成功复制的字节数**，出现错误时返回负值。若`*off_in`的文件偏移超过`fd_in`的大小，则直接返回 0，不进行复制。若`off_in`或`off_out`为负值，则直接返回-1。`fd_out`的文件偏移保证不会超过文件的总字节数。

本题中，其中一个文件描述符一定是管道，另一个一定是普通的磁盘文件。`flags`总为0，没有实际作用。

特殊说明：

1. 尽可能向管道写入数据（当管道满时，阻塞等待）。
2. 如果文件`fd_in`的剩余部分小于`len`，则将`fd_in`文件剩余的全部内容写入管道`fd_out`。
3. 读取管道时，允许读取的数据量小于`len`，但在管道有数据时不可返回0（当管道空时，阻塞等待）。

### 测试点（50分）

1. 测试的`fd_in`为普通文件，`fd_out`为管道，且管道在读写完成前不会关闭(10分)
2. 测试的`fd_in`为管道，`fd_out`为普通文件，且管道在读写完成前不会关闭(10分)
3. 测试文件到管道的拷贝时，普通文件`fd_in`剩余的字节数小于`len`(10分)
4. 测试管道到文件的拷贝时，`fd_in`管道数据不足`len` bytes(10分)
5. 边界情况处理(10分)


```cpp
inline long syscall_splice(int fd_in, long *off_in, int fd_out, long *off_out, size_t len, unsigned int flags)
{
    kout[Debug] << "Entering syscall_splice" << endl;
    kout[Debug] << "fd_in: " << fd_in << ", fd_out: " << fd_out << ", len: " << len << ", flags: " << flags << endl;

    if (fd_in < 0 || fd_out < 0 || len <= 0) {
        kout[Debug] << "Invalid parameters: fd_in or fd_out is negative, or len is non-positive" << endl;
        return -1;
    }

    if ((off_in && *off_in < 0) || (off_out && *off_out < 0)) {
        kout[Debug] << "Invalid offsets: off_in or off_out is negative" << endl;
        return -1;
    }

    Process *cur_proc = pm.getCurProc();
    file_object *fo_in = fom.get_from_fd(cur_proc->fo_head, fd_in);
    if (fo_in == nullptr) {
        kout[Error] << "Syscall_splice can't open fd_in" << endl;
        return -1;
    }
    file_object *fo_out = fom.get_from_fd(cur_proc->fo_head, fd_out);
    if (fo_out == nullptr) {
        kout[Error] << "Syscall_splice can't open fd_out" << endl;
        return -1;
    }

    bool is_pipe_in = (off_in == nullptr);
    bool is_pipe_out = (off_out == nullptr);
    kout[Debug] << "is_pipe_in: " << is_pipe_in << ", is_pipe_out: " << is_pipe_out << endl;
    if (is_pipe_in && off_in != nullptr) {
        kout[Error] << "Invalid offset for pipe input" << endl;
        return -1;
    }
    if (is_pipe_out && off_out != nullptr) {
        kout[Error] << "Invalid offset for pipe output" << endl;
        return -1;
    }

    long long read_offset = 0;
    if (!is_pipe_in) {
        read_offset = *off_in;
        if (read_offset > fo_in->file->size()) {
            kout[Debug] << "read_offset exceeds file size" << endl;
            return 0;
        }
        if(fo_in->file->size()-read_offset<len){
            kout[Debug] << "Adjusting len from " << len << " to " << (fo_in->file->size() - read_offset) << endl;
            len=fo_in->file->size();
        }
    }

    long long write_offset = 0;
    if (!is_pipe_out) {
        write_offset = *off_out;
        if (write_offset > fo_out->file->size()) {
            kout[Debug] << "write_offset exceeds file size" << endl;
            return 0;
        }
    }
    unsigned char *buffer = new unsigned char[len];
    VirtualMemorySpace::EnableAccessUser();

    // 从输入文件描述符中读取数据
    long long bytes_read = -1;
    if (is_pipe_in) {
        kout[Debug] << "Reading from pipe" << endl;
        fo_in->pos_k=0;
        bytes_read = fom.read_fo(fo_in, buffer, len);
        fo_in->pos_k=0;
    } else {
        kout[Debug] << "Reading from file, offset: " << read_offset << endl;
        fo_in->pos_k=read_offset;
        bytes_read = fom.read_fo(fo_in, buffer, len);
        fo_in->pos_k=read_offset;
    }
    
    if (bytes_read <= 0) {
         kout[Debug] << "Read failed or no data to read, bytes_read: " << bytes_read << endl;
        delete[] buffer;
        VirtualMemorySpace::DisableAccessUser();
        return bytes_read;
    }

    long long bytes_written = -1;
    if (is_pipe_out) {
        kout[Debug] << "Writing to pipe" << endl;
        bytes_written = fom.write_fo(fo_out, buffer, bytes_read);
        fo_out->pos_k=0;
    } else {
         kout[Debug] << "Writing to file, offset: " << write_offset << endl;
        fo_out->pos_k=write_offset;
        bytes_written = fom.write_fo(fo_out, buffer, bytes_read);
        fo_out->pos_k=write_offset;
    }

    delete[] buffer;
    VirtualMemorySpace::DisableAccessUser();

    if (!is_pipe_in) {
        *off_in += bytes_read;
    }
    if (!is_pipe_out) {
        *off_out += bytes_written;
    }

    kout[Debug] << "Bytes written: " << bytes_written << endl;
    return bytes_written;
}
```
主要用于在文件描述符之间传输数据。首先，它检查传入的参数的有效性。如果输入文件描述符 (`fd_in`) 或输出文件描述符 (`fd_out`) 负值，或数据长度 (`len`) 非正，则返回错误。其次，函数还验证了输入和输出文件的偏移量是否有效，确保它们在合理的范围内，尤其是当这些文件描述符是管道时。
接下来，函数通过当前进程的文件对象列表获取输入和输出文件对象。如果输入文件描述符无效或输出文件描述符无效，函数返回错误。然后，函数根据输入和输出文件描述符是否为管道来确定是否使用偏移量进行读写。如果不是管道，它将检查并调整偏移量以确保它们在文件的有效范围内。同时，函数分配了一个缓冲区用于存储从输入文件读取的数据，并设置虚拟内存的访问权限。
在数据传输的核心部分，函数从输入文件描述符读取数据到缓冲区。如果输入文件描述符是管道，读取操作从管道的起始位置开始，否则从指定的偏移量开始。读取操作完成后，函数将数据写入到输出文件描述符。如果输出文件描述符是管道，则从管道的起始位置开始写入，否则从指定的偏移量开始。函数处理完所有操作后，释放缓冲区，并更新文件偏移量。如果数据读取或写入失败，函数会返回失败的字节数。
