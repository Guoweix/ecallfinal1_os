## 文件系统
### VFSM
文件系统先通过VFSM将管理虚拟文件系统，虽然目前只支持FAT32,但是方便了将来的扩展
VFSM通过链表去管理当前打开的文件，通过路径去实现所有操作。同时提供了一些路径操作的方式.
除此之外VFSM的其他操作是通过调用其他VFS实现的，由于我们这里只实现了FAT32,所以VFSM主要是通过调用FAT32的功能实现
```cpp
class VFSM
{
private:
    FAT32FILE* OpenedFile;

    FAT32FILE* find_file_by_path(char* path, bool& isOpened);

public:
    FAT32FILE* open(const char* path, char* cwd);
    FAT32FILE* open(FAT32FILE* file);
    void close(FAT32FILE* t);

    void showRootDirFile();
    bool create_file(const char* path, char* cwd, char* fileName, Uint8 type = FATtable::FILE);
    bool create_dir(const char* path, char* cwd, char* dirName);
    bool del_file(const char* path, char* cwd);
    bool link(const char* srcpath, const char* ref_path, char* cwd);//ref_path为被指向的文件
    bool unlink(const char* path, char* cwd);
    bool unlink(char* abs_path);
    FAT32FILE* get_next_file(FAT32FILE* dir, FAT32FILE* cur = nullptr, bool (*p)(FATtable* temp) = VALID); // 获取到的dir下cur的下一个满足p条件的文件，如果没有则返回空

    char* unified_path(const char* path, char* cwd);
    void show_opened_file();
    bool init();
    bool destory();
    FAT32FILE* get_root();
};

```
VFSM中还提供了PATH的通用工具用于处理路径。
### FAT32文件系统
FAT32文件系统的难点在于从网络中的各个FAT版本中构建出一个可以读取vfat的协议，根据协议编写相应的文件系统。
- 初始化
从FAT32前512个字节中读取出基本的Fat32数据，包括fat1lba fat2lba 和 datalba的分布。
- 基础功能
    - clus号到lba,lba到clus号
    - 从clus中读取数据，向clus中填写数据,清除clus数据
    - 设置clus的下一个clus
    - 查找空的clus
    - 读写fatTable
- 文件功能实现
    - 打开文件
        通过读写fatTable中的clus找到装载文件的clus,递归处理，就可以读取到目标路径
    - 读取写件
        通过读取fatTable中的clus找到文件内容，且可以通过获取下一个clus读取到全部的信息。设置同理，对于多出的文件内容，可以通过查找空的clus进行设置
    - 设置文件基本信息
        设置fatTable即可设置文件基本信息


### open
VFSM通过链表管理打开的文件，将打开的文件存储到链表中，加快文件读取速度。同时mount也是Fat32不支持的操作，所以在用另一个链表去管理mount的映射关系

### fileObject
通过进一步抽象，将文件抽象成为FileObject,同时使用FileObjectManage
进行管理，获取相应的文件描述符，来管理文件。仍然使用链表管理。
<p align="right">By:郭伟鑫</p>