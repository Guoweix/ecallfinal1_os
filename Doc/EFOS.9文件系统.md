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

##### 介绍
Ext4文件系统是以块（Block）的方式管理文件的，默认单位为4KB一块。一个1GB大小的空间，ext4 文件系统将它分隔成了0~7的8个Group。每个Group中又有superblock、Group descriptors、bitmap、Inode table、usrer data、还有一些保留空间。
![image.png](https://cdn.nlark.com/yuque/0/2024/png/44788784/1723972648107-c5c4d6fe-2309-437b-82b2-e4b911012087.png#averageHue=%235fb549&clientId=u7214cbf1-2f81-4&from=paste&height=193&id=u8e13d879&originHeight=290&originWidth=543&originalType=binary&ratio=1.5&rotation=0&showTitle=false&size=46929&status=done&style=none&taskId=u6ed4a579-113b-43b3-941b-1285680abb7&title=&width=362)
**inode（索引节点）**：inode是文件系统中的一个数据结构，用于存储文件或目录的元数据信息，如文件类型、权限、拥有者、大小、时间戳等。每个文件或目录都有一个对应的 inode来描述其属性和位置。
**数据区块：**数据区块是用于存储文件内容的实际数据块。当文件被创建或修改时，其内容被存储在数据区块中。ext4 文件系统将文件内容分散存储在多个数据块中，以提高文件系统的效率和性能。
**超级块：**超级块是 ext4 文件系统的关键数据结构之一，它存储了文件系统的元数据信息，如文件系统的大小、inode数量、数据块数量、挂载选项等。每个文件系统只有一个超级块，位于文件系统的开头位置。
**块组（Block Group）：**块组是 ext4 文件系统的逻辑单元，用于组织和管理文件系统中的数据。每个块组包含一组连续的数据块、inode和位图等。块组有助于提高文件系统的性能和可管理性。
**位图：**位图是用于跟踪数据块和 inode的使用情况的数据结构。每个块组都有自己的位图，用于标记已分配和未分配的数据块和 inode。
![image.png](https://cdn.nlark.com/yuque/0/2024/png/44788784/1723972660563-efc619ea-df42-4cad-b6a3-833b1b93d9bb.png#averageHue=%23333232&clientId=u7214cbf1-2f81-4&from=paste&height=436&id=udd07ed50&originHeight=654&originWidth=1439&originalType=binary&ratio=1.5&rotation=0&showTitle=false&size=781098&status=done&style=none&taskId=uda82e2f6-3e10-45c0-b3b9-92b66b70914&title=&width=959.3333333333334)
通过移植官方给的C实现的EXT4到我们的项目。我们构造了myext4.hpp用来对接官方项目和我们的vfsm.hpp。
##### ext4node
```cpp
class ext4node : public FileNode {

    DEBUG_CLASS_HEADER(ext4node);

public:
    ext4_file fp;
    ext4_dir fd;
    Sint64 offset;

    void initlink(ext4_file tb, const char* Name, EXT4* fat_);
    void initfile(ext4_file tb, const char* Name, EXT4* fat_);
    void initdir(ext4_dir tb, const char* Name, EXT4* fat_);

    bool set_name(char* _name) override; //
    Sint64 read(void* dst, Uint64 pos, Uint64 size) override; //
    Sint64 read(void* dst, Uint64 size) override; //
    Sint64 write(void* src, Uint64 pos, Uint64 size) override; //
    Sint64 write(void* src, Uint64 size) override; //
    Sint64 close()
    {
        if (name) {
            delete[] name;
        }
        name=nullptr;
    }

    // bool del();//这个我看fat32也没有实现，而是实现vfs的del，所以我也先空着了

    void show(); //
    ext4node() {
        // kout<<"ext4node create"<<endl;
    };
    ~ext4node() {};
};
```
继承FileNode，FileNode即通用的文件结点接口。查看ext4.h中的结构体信息，我们提取出
```cpp
/**@brief   File descriptor. */
typedef struct ext4_file {

    /**@brief   Mount point handle.*/
    struct ext4_mountpoint *mp;

    /**@brief   File inode id.*/
    uint32_t inode;

    /**@brief   Open flags.*/
    uint32_t flags;

    /**@brief   File size.*/
    uint64_t fsize;

    /**@brief   Actual file position.*/
    uint64_t fpos;
} ext4_file;
```
以及用于存储文件夹格式的
```cpp
/**@brief   Directory descriptor. */
typedef struct ext4_dir {
    /**@brief   File descriptor.*/
    ext4_file f;
    /**@brief   Current directory entry.*/
    ext4_direntry de;
    /**@brief   Next entry offset.*/
    uint64_t next_off;
} ext4_dir;
```
，更有负责获取文件夹中下一个文件的结构体用于实现get_next_file：
```cpp
/**@brief   Directory entry descriptor. */
typedef struct ext4_direntry {
    uint32_t inode;
    uint16_t entry_length;
    uint8_t name_length;
    uint8_t inode_type;
    uint8_t name[255];
} ext4_direntry;
```
还有用于存储文件挂载点信息的结构体：
```cpp
/**@brief   Some of the filesystem stats. */
struct ext4_mount_stats {
    uint32_t inodes_count;
    uint32_t free_inodes_count;
    uint64_t blocks_count;
    uint64_t free_blocks_count;

    uint32_t block_size;
    uint32_t block_group_count;
    uint32_t blocks_per_group;
    uint32_t inodes_per_group;

    char volume_name[16];
};
```
。熟悉需要用到的结构体信息并将这些结构体加入ext4node类的成员变量中，方便成员函数的调用。对于成员函数，运用在ext4.h中的几个重要函数来实现：
```cpp
/**@brief   File open function.
 *
 * @param   file  File handle.
 * @param   path  File path, has to start from mount point:/my_partition/file.
 * @param   flags File open flags.
 *  |---------------------------------------------------------------|
 *  |   r or rb                 O_RDONLY                            |
 *  |---------------------------------------------------------------|
 *  |   w or wb                 O_WRONLY|O_CREAT|O_TRUNC            |
 *  |---------------------------------------------------------------|
 *  |   a or ab                 O_WRONLY|O_CREAT|O_APPEND           |
 *  |---------------------------------------------------------------|
 *  |   r+ or rb+ or r+b        O_RDWR                              |
 *  |---------------------------------------------------------------|
 *  |   w+ or wb+ or w+b        O_RDWR|O_CREAT|O_TRUNC              |
 *  |---------------------------------------------------------------|
 *  |   a+ or ab+ or a+b        O_RDWR|O_CREAT|O_APPEND             |
 *  |---------------------------------------------------------------|
 *
 * @return  Standard error code.*/
int ext4_fopen(ext4_file *file, const char *path, const char *flags);

/**@brief   File close function.
 *
 * @param   file File handle.
 *
 * @return  Standard error code.*/
int ext4_fclose(ext4_file *file);

/**@brief   Read data from file.
 *
 * @param   file File handle.
 * @param   buf  Output buffer.
 * @param   size Bytes to read.
 * @param   rcnt Bytes read (NULL allowed).
 *
 * @return  Standard error code.*/
int ext4_fread(ext4_file *file, void *buf, size_t size, size_t *rcnt);

/**@brief   Write data to file.
 *
 * @param   file File handle.
 * @param   buf  Data to write
 * @param   size Write length..
 * @param   wcnt Bytes written (NULL allowed).
 *
 * @return  Standard error code.*/
int ext4_fwrite(ext4_file *file, const void *buf, size_t size, size_t *wcnt);

/**@brief   File seek operation.
 *
 * @param   file File handle.
 * @param   offset Offset to seek.
 * @param   origin Seek type:
 *              @ref SEEK_SET
 *              @ref SEEK_CUR
 *              @ref SEEK_END
 *
 * @return  Standard error code.*/
int ext4_fseek(ext4_file *file, int64_t offset, uint32_t origin);

/**@brief Rename/move directory.
 *
 * @param path     Source path.
 * @param new_path Destination path.
 *
 * @return  Standard error code. */
int ext4_dir_mv(const char *path, const char *new_path);

/**@brief   Create new directory.
 *
 * @param   path Directory name.
 *
 * @return  Standard error code.*/
int ext4_dir_mk(const char *path);

/**@brief   Directory open.
 *
 * @param   dir  Directory handle.
 * @param   path Directory path.
 *
 * @return  Standard error code.*/
int ext4_dir_open(ext4_dir *dir, const char *path);

/**@brief   Directory close.
 *
 * @param   dir directory handle.
 *
 * @return  Standard error code.*/
int ext4_dir_close(ext4_dir *dir);

/**@brief   Return next directory entry.
 *
 * @param   dir Directory handle.
 *
 * @return  Directory entry id (NULL if no entry)*/
const ext4_direntry *ext4_dir_entry_next(ext4_dir *dir);
```
即可实现从FileNode处继承来的函数
##### EXT4
EXT4继承先前的VFS，方便与vfsm对接。
```cpp
class EXT4 : public VFS {

    DEBUG_CLASS_HEADER(EXT4);
    friend class ext4node;
    friend class VFSM;

public:
    char* FileSystemName() { return nullptr; };
    void show_all_file_in_dir(ext4node* dir, Uint32 level = 0); //
    FileNode** get_all_file_in_dir(FileNode* dir, bool (*p)(FileType type)) override
    {
        return nullptr;
    }; //
    ext4node* open(const char* _path, FileNode* parent) override; //
    ext4node* get_node(const char* path) override
    {
        return nullptr;
    };
    bool close(FileNode* p) override
    {
        return true;
    }; //
    bool del(FileNode* file) override;

    ext4node* create_file(FileNode* dir_, const char* fileName, FileType type = FileType::__FILE) override; //
    ext4node* create_dir(FileNode* dir_, const char* fileName) override; //

    bool init() { return 1; }; //

    void get_next_file(ext4node* dir, ext4node* cur, ext4node* tag); //
    EXT4() {};
    ~EXT4() {};
};
```
重写继承自vfs的函数，用ext4内部函数来具体实现。比较重要的是open，open沿着绝对路径打开并将打开的文件挂载到文件树上![image.png](https://cdn.nlark.com/yuque/0/2024/png/44788784/1723972593290-cd292b5d-d62e-40b4-90e0-e9f40a4e8d3e.png#averageHue=%23f6f4f3&clientId=u7214cbf1-2f81-4&from=paste&height=299&id=u005c6f1b&originHeight=449&originWidth=708&originalType=binary&ratio=1.5&rotation=0&showTitle=false&size=118973&status=done&style=none&taskId=udf87bc4d-e060-45cb-9445-8eac5862f1e&title=&width=472)
show_all_file_in_dir则根据get_next_file来实现，get_next_file则根据ext.h中的ext_direntry来实现。
