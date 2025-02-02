#include "File/FAT32.hpp"
#include "File/FileEx.hpp"
#include "File/lwext4_include/ext4_types.h"
#include "Library/KoutSingle.hpp"
#include "Trap/Interrupt.hpp"
#include "Types.hpp"
#include <File/FileObject.hpp>
#include <File/vfsm.hpp>
#include <Process/Process.hpp>

// FileNode* STDIO = nullptr;

void FileObjectManager::init_proc_fo_head(Process* proc)
{
    if (proc == nullptr) {
        kout[Fault] << "The Process has not existed!" << endl;
        return;
    }

    // 初始化进程的虚拟头节点
    // 使用场景下必须保证一定是空的
    if (proc->fo_head != nullptr) {
        // kout[Info] << "The Process's fo_head is not Empty!" << endl;
        free_all_flobj(proc->fo_head);
        delete proc->fo_head;
    }
    proc->fo_head = new file_object;
    if (proc->fo_head == nullptr) {
        kout[Fault] << "The fo_head malloc Fail!" << endl;
        return;
    }
    proc->fo_head->next = nullptr;
    proc->fo_head->fd = -1; // 头节点的fd默认置为-1
    proc->fo_head->file = nullptr; // 头节点的file指针置空 不会有任何引用和指向
    proc->fo_head->pos_k = -1; // 这些成员在头节点的定义下均不会使用 置-1即可 无符号数类型下
    proc->fo_head->flags = file_flags::RDONLY;
    proc->fo_head->mode = -1;
}

int FileObjectManager::get_count_fdt(file_object* fo_head)
{
    // 从虚拟头节点出发去统计这个链表的长度即可
    int ret_count = 0;
    if (fo_head == nullptr) {
        kout[Fault] << "The fo_head is Empty!" << endl;
        return ret_count;
    }

    file_object* fo_ptr = fo_head->next;
    while (fo_ptr != nullptr) {
        ret_count++;
        fo_ptr = fo_ptr->next;
    }
    return ret_count;
}

int FileObjectManager::find_sui_fd(file_object* fo_head)
{
    if (fo_head == nullptr) {
        kout[Fault] << "The fo_head is Empty!" << endl;
        return 0;
    }

    int cur_len = get_count_fdt(fo_head);
    int st[cur_len + 3 + 1]; // 当前有这么多节点 使用cur_len+1个数一定可以找到合适的fd
    MemsetT<int>(st, 0, cur_len + 3 + 1);
    // st[0] = 1; // 标准输出的fd是默认分配好的 可能被占用
    // st[1] = 1;
    // st[2] = 1;
    file_object* fo_ptr = fo_head->next;
    while (fo_ptr != nullptr) {
        int used_fd = fo_ptr->fd;
        if (used_fd > cur_len) {
            // 这个使用的fd已经超出当前数组长度
            // 不统计即可
            fo_ptr = fo_ptr->next;
            continue;
        }
        st[used_fd] = 1;
        fo_ptr = fo_ptr->next;
    }
    int ret_fd = -1;
    for (int i = 0; i <= cur_len + 3; i++) {
        if (!st[i]) {
            // 找到第一个符合的最小的非负整数fd
            ret_fd = i;
            break;
        }
    }
    return ret_fd;
}

file_object* FileObjectManager::create_flobj(file_object* fo_head, int fd)
{
    if (fo_head == nullptr) {
        kout[Fault] << "The fo_head is Empty!" << endl;
        return nullptr;
    }

    if (fd < -1) {
        kout[Fault] << "The fd cannot be FD!" << endl;
        return nullptr;
    }

    file_object* new_fo = new file_object;
    if (new_fo == nullptr) {
        kout[Fault] << "The fo_head malloc Fail!" << endl;
        return nullptr;
    }
    int new_fd = fd;
    if (fd == -1) {
        // 自动分配一个最小的合适的非负整数作为fd
        new_fd = find_sui_fd(fo_head);
    }
    new_fo->fd = new_fd;
    new_fo->file = nullptr; // 相关属性在之后会有相关设置
    new_fo->next = nullptr;
    new_fo->flags = file_flags::RDONLY;
    new_fo->mode = -1;
    new_fo->pos_k = 0;
    // 分配完成之后插入这个链表的最后一个位置即可
    file_object* fo_ptr = fo_head;
    while (fo_ptr->next != nullptr) {
        fo_ptr = fo_ptr->next;
    }
    fo_ptr->next = new_fo;
    // kout[Info]<<"FileObjectManager::create_flobj  fd is "<<new_fd<<endl;
    return new_fo; // 返回这个创建的新的节点用来设置相关属性
}

file_object* FileObjectManager::get_from_fd(file_object* fo_head, int fd)
{
    if (fo_head == nullptr) {
        kout[Fault] << "The fo_head is Empty!" << endl;
        return nullptr;
    }

    // 简单遍历链表返回即可
    file_object* ret_fo = nullptr;
    file_object* fo_ptr = fo_head->next;
    while (fo_ptr != nullptr) {
        if (fo_ptr->fd == fd) {
            ret_fo = fo_ptr;
            break;
        }
        fo_ptr = fo_ptr->next;
    }
    if (ret_fo == nullptr) {
        return nullptr;
        // 对于未找到的情况加个输出信息
        // kout[yellow] << "The specified fd cannot be found!" << endl;
    }
    return ret_fo;
}

void FileObjectManager::free_all_flobj(file_object* fo_head)
{
    if (fo_head == nullptr) {
        kout[Fault] << "The fo_head is Empty!" << endl;
        return;
    }

    // 接下来就是删除除虚拟头节点外链表所有的节点
    // 对于单个虚拟头节点资源的释放交给进程自己去管理
    // 释放相关的资源
    // 注意这里只是和链表的交互
    // 依旧不需要去管理具体的打开文件的资源
    // 引用计数相关的问题是在文件相关操作被处理
    file_object* fo_ptr = fo_head;
    file_object* fo_del = nullptr;
    while (fo_ptr->next != nullptr) {
        fo_del = fo_ptr->next;
        fo_ptr->next = fo_ptr->next->next;
        // kout<<"FileObjectManager::free_all_flobj"<<fo_del<<endl;
        delete fo_del;
    }
    return;
}

int FileObjectManager::add_fo_tolist(file_object* fo_head, file_object* fo_added)
{
    if (fo_head == nullptr) {
        kout[Fault] << "The fo_head is Empty!" << endl;
        return -1;
    }

    if (fo_added == nullptr) {
        kout[Warning] << "The fo_added is Empty!" << endl;
        return -1;
    }

    // 因为是将新的fo插入链表
    // 所以对于插入的fo的fd需要检查 防止出现重复的情况
    if (fo_added->fd == -1 || fo_added->fd < 0) {
        // -1或负即在当前fo链表基础上自动分配
        int fd_added = find_sui_fd(fo_head);
        fo_added->fd = fd_added;
    } else {
        // 检查一下当前这个插入的fo的fd是否已经在待插入链表上存在了
        file_object* fo_ptr = fo_head->next;
        bool is_exist = false;
        while (fo_ptr != nullptr) {
            if (fo_ptr->fd == fo_added->fd) {
                is_exist = true;
                break;
            }
            fo_ptr = fo_ptr->next;
        }
        if (is_exist) {
            int fd_added = find_sui_fd(fo_head);
            fo_added->fd = fd_added;
        }
    }

    file_object* fo_ptr = fo_head;
    while (fo_ptr->next != nullptr) {
        fo_ptr = fo_ptr->next;
    }
    fo_ptr->next = fo_added;
    // 返回新插入的fo节点的fd
    return fo_added->fd;
}

void FileObjectManager::delete_flobj(file_object* fo_head, file_object* del)
{
    if (fo_head == nullptr) {
        kout[Fault] << "The fo_head is Empty!" << endl;
        return;
    }

    if (del == nullptr) {
        kout[Warning] << "The deleted fo is Empty!" << endl;
        return;
    }

    file_object* fo_ptr = fo_head->next;
    file_object* fo_pre = fo_head;
    bool flag = false;
    while (fo_ptr != nullptr) {
        if (fo_ptr == del) {
            // 当前这个节点是需要被删除的
            // 理论上讲fo节点是唯一的 这里删除完了即可退出了
            // 出于维护链表结构的统一性模板
            fo_pre->next = fo_ptr->next;
            flag = true;
            delete fo_ptr;
            fo_ptr = fo_pre;
        }
        fo_pre = fo_ptr;
        fo_ptr = fo_ptr->next;
    }
    ASSERTEX(flag, "FileObject::delete_flobj  can't find del node");
    return;
}

bool FileObjectManager::set_fo_fd(file_object* fo, int fd)
{
    if (fo == nullptr) {
        kout[Fault] << "The fo is Empty cannot be set!" << endl;
        return false;
    }

    if (fd < 0) {
        kout[Fault] << "The fd to be set is Negative!" << endl;
        return false;
    }

    fo->fd = fd;
    return true;
}

bool FileObjectManager::set_fo_file(file_object* fo, FileNode* file)
{
    if (fo == nullptr) {
        kout[Fault] << "The fo is Empty cannot be set!" << endl;
        return false;
    }

    if (file == nullptr) {
        kout[Fault] << "The file to be set is Empty!" << endl;
        return false;
    }

    fo->file = file;
    return true;
}

bool FileObjectManager::set_fo_pos_k(file_object* fo, Uint64 pos_k)
{
    if (fo == nullptr) {
        kout[Fault] << "The fo is Empty cannot be set!" << endl;
        return false;
    }
    if (fo->file->TYPE & FileType::__PIPEFILE) {
        return false;
    }

    fo->pos_k = pos_k;
    return true;
}

bool FileObjectManager::set_fo_flags(file_object* fo, file_flags flags)
{
    if (fo == nullptr) {
        kout[Fault] << "The fo is Empty cannot be set!" << endl;
        return false;
    }

    fo->flags = flags;
    return true;
}

bool FileObjectManager::set_fo_mode(file_object* fo, Uint64 mode)
{
    if (fo == nullptr) {
        kout[Fault] << "The fo is Empty cannot be set!" << endl;
        return false;
    }

    fo->mode = mode;
    return true;
}

Sint64 FileObjectManager::read_fo(file_object* fo, void* dst, Uint64 size)
{

    // kout[Debug] << "read_fo"<<endl;
    if (fo == nullptr) {
        kout[Fault] << "Read fo the fo is NULL!" << endl;
        return -1;
    }
    if (dst == nullptr) {
        kout[Fault] << "Read fo the dst pointer is NULL!" << endl;
        return -1;
    }

    // kout[Debug] << "read_fo1"<<endl;
    FileNode* file = fo->file;
    if (file == nullptr) {
        kout[Fault] << "Read fo the file pointer is NULL!" << endl;
        return -1;
    }
    // kout[Debug] << (void*)fo->file->vfs << " file " << file->name << " dst " << (void*)dst << " pos_k " << fo->pos_k <<" size "<<size<< endl;

    Sint64 rd_size;
    // kout[Debug] << "read_fo1 "<<()dst<<endl;
    rd_size = file->read((unsigned char*)dst, fo->pos_k, size);
    if (rd_size >= 0) {
        fo->pos_k += rd_size;
    }

    return rd_size;
}

Sint64 FileObjectManager::write_fo(file_object* fo, void* src, Uint64 size)
{
    if (fo == nullptr) {
        kout[Fault] << "Write fo the fo is NULL!" << endl;
        return -1;
    }
    if (src == nullptr) {
        kout[Fault] << "Write fo the src pointer is NULL!" << endl;
        return -1;
    }

    FileNode* file = fo->file;
    if (file == nullptr) {
        kout[Fault] << "Write fo the file pointer is NULL!" << endl;
        return -1;
    }

    Sint64 wr_size;
    /*    if (file->TYPE & FAT32FILE::__PIPEFILE) {
           PIPEFILE* pfile = (PIPEFILE*)fo->file;
           wr_size = pfile->write((unsigned char*)src,  size);
       } else { */
    // if (file==STDIO) {
    // kout[Info]<<"file is STDIO"<<endl;
    // }
    // kout[Info] << "FileObject::write file " << file << endl;
    wr_size = file->write((unsigned char*)src, fo->pos_k, size);
    if (wr_size >= 0) {
        fo->pos_k += wr_size;
    }

    file->fileSize = size; // 有问题，但是也许是trick

    // }
    return wr_size;
}

void FileObjectManager::seek_fo(file_object* fo, Sint64 bias, Sint32 base)
{
    if (base == Seek_beg) {
        fo->pos_k = bias;
    } else if (base == Seek_cur) {
        fo->pos_k += bias;
    } else if (base == Seek_end) {
        fo->pos_k = fo->file->fileSize;
    }
}

bool FileObjectManager::close_fo(Process* proc, file_object* fo)
{
    if (proc == nullptr) {
        kout[Fault] << "Close fo the Process is Not Exist!" << endl;
        return false;
    }
    if (fo == nullptr) {
        kout[Warning] << "The fo is Empty not need to be Closed!" << endl;
        return true;
    }
    if ((fo->file->TYPE & FileType::__PIPEFILE) && (fo->canWrite())) {
        PIPEFILE* fp = (PIPEFILE*)fo->file;
        // kout[DeBug] << "close pipefile writeRef " << fp->writeRef << endl;

        fp->writeRef--;
        if (fp->writeRef == 0) {
            char* t = new char;
            *t = 4;
            // kout[Fault]<<"EOF "<<endl;
            fom.write_fo(fo, t, 1);
            delete t;
        }
    }
    // 关闭这个文件描述符
    // 首先通过vfsm的接口直接对于fo对于的file类调用close函数
    // 这里的close接口会自动处理引用计数相关文件
    // 进程完全不需要进行对文件的任何操作
    // 这就是这一层封装和隔离的妙处所在
    FileNode* file = fo->file;
    kout[Info] << "close_fo fd" << fo->fd << " " << fo->file << fo->file->name << endl;

    vfsm.close(file);
    // 同时从进程的文件描述符表中删去这个节点
    file_object* fo_head = proc->fo_head;
    file = nullptr;
    fom.delete_flobj(fo_head, fo);
    return true;
}

file_object* FileObjectManager::duplicate_fo(file_object* fo)
{
    if (fo == nullptr) {
        kout[Fault] << "The fo is Empty cannot be set!" << endl;
        return nullptr;
    }

    // 拷贝当前的fo并返回一个新的fo即可
    file_object* dup_fo = new file_object;
    if (dup_fo == nullptr) {
        kout[Fault] << "The fo_head malloc Fail!" << endl;
        return nullptr;
    }
    dup_fo->next = nullptr;
    // 直接原地赋值 不调用函数了 节省开销
    dup_fo->fd = -1; // 这个fd在需要插入这个fo节点时再具体化
                     //
    // kout[DeBug]<<"duplicate "<<(void *)fo<<endl;
    dup_fo->file = fo->file; // 关键是file flags这些信息的拷贝
    fo->file->RefCount++;

    if ((fo->file->TYPE & FileType::__PIPEFILE) && (fo->canWrite())) {
        // kout[Fault]<<"dup pipe"<<endl;
        // kout[DeBug] << "should appear 2 times " << endl;
        PIPEFILE* t = (PIPEFILE*)fo->file;
        t->writeRef++;
    }

    // char a[200];
    // dup_fo->file->read(a,200);
    // kout[DeBug]<<"duplicate "<<a<<endl;

    dup_fo->flags = fo->flags;
    dup_fo->pos_k = fo->pos_k;
    return dup_fo;
}

/* file_object* FileObjectManager::duplicate_Link(file_object* fo_tar, file_object* fo_src)// 传入头节
{

    file_object * t;
    t=fo_src->next;
    file_object * new_node;
    while (t) {
        new_node=fom.duplicate_fo(t);
        t=t->next;
    }

}
 */
// 声明的全局变量实例化
FileObjectManager fom;