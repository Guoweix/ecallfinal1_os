#include "File/FileEx.hpp"
#include "Library/KoutSingle.hpp"
#include "Library/Pathtool.hpp"
#include "Trap/Interrupt.hpp"
#include "Types.hpp"
#include <File/FAT32.hpp>
// #include <File/lwext4_include/ext4.h>
#include <File/myext4.hpp>
#include <File/vfsm.hpp>

// FileNode::FileNode(VFS* _VFS, Uint64 _flags)
// {
// vfs=_VFS;

// }
//
bool FileNode::IsDir()
{
    return TYPE & FileType::__DIR;
}
bool FileNode::del()
{
    kout[Error] << "FileNode::del " << endl;
    return false;
}

Sint64 FileNode::read(void* dst, Uint64 pos, Uint64 size)
{

    kout[Error] << this << "FileNode::read " << endl;
    return false;
}

Sint64 FileNode::read(void* dst, Uint64 size)
{

    kout[Error] << " FileNode::read " << endl;
    return false;
}

Sint64 FileNode::write(void* src, Uint64 size)
{
    kout[Error] << "FileNode::write " << endl;
    return false;
}

Sint64 FileNode::write(void* src, Uint64 pos, Uint64 size)
{

    kout[Error] << "FileNode::write " << endl;
    return false;
}

bool FileNode::ref(file_object* f)
{
    RefCount++;
    return true;
}
bool FileNode::unref(file_object* f)
{

    RefCount--;
    return true;
}

bool FileNode::set_name(char* _name)
{
    if (name) {
        delete[] name;
    }
    name = new char[strlen(_name) + 5];
    strcpy(name, _name);
    return true;
}

const char* FileNode::get_name()
{
    return name;
}

void FileNode::set_parent(FileNode* _parent)
{
    parent = _parent;
}

Sint64 FileNode::size()
{
    return fileSize;
}

FileNode::~FileNode()
{
    delete[] name;
    while (child != nullptr) {
        delete child;
    }
    if (pre != nullptr) {
        pre->next = next;
    }
    if (next != nullptr) {
        kout << "next:" << next->name << endl;
    }
    if (parent != nullptr) {
        if (parent->child == this)
            parent->child = next;
    }
}

static struct ext4_bcache* bc;
struct ext4_blockdev* ext4_blockdev_get(void);
static struct ext4_blockdev* bd;

bool VFSM::init()
{

    kout << "open_filedev start:" << endl;
    bd = ext4_blockdev_get();
    if (!bd) {
        kout << "open_filedev: fail" << endl;
        return false;
    }

    kout << "ext4_device_register: start:" << endl;
    int r = ext4_device_register(bd, "ext4_fs");
    if (r != EOK) {
        kout << "ext4_device_register: rc = " << r << endl;
        return false;
    }

    kout << "ext4_mount: start:" << endl;
    r = ext4_mount("ext4_fs", "/", false);
    if (r != EOK) {
        kout << "ext4_mount: rc =" << r << endl;
        return false;
    }

    kout << "ext4_recover: start:" << endl;
    r = ext4_recover("/");
    if (r != EOK && r != ENOTSUP) {
        kout << "ext4_recover: rc =" << r << endl;
        return false;
    }

    kout << "ext4_journal_start: start:" << endl;
    r = ext4_journal_start("/");
    if (r != EOK) {
        kout << "ext4_journal_start: rc = " << r << endl;
        return false;
    }

    ext4_cache_write_back("/", 1);

    ext4_dir ed;
    ext4_dir_open(&ed, "/");
    kout << "ext4_dir_open: sucess:" << endl;

    ext4node* temp = new ext4node;
    // temp->show();
    temp->RefCount++;
    EXT4* e1 = new EXT4;
    temp->initdir(ed, (char*)".ROOT", e1);
    temp->show();
    e1->root = temp;
    kout << "ready!" << endl;

    root = (FileNode*)temp;
    temp->TYPE |= FileType::__DIR;
    temp->TYPE |= FileType::__VFS;
    temp->TYPE |= FileType::__ROOT;

    /*
     FAT32* fat = new FAT32;
     FATtable a;
     a.size = 0;
     FAT32FILE* t;
     t = new FAT32FILE(a, ".ROOT", fat);
     kout[Info] << "FAT32 " << (void*)fat << endl;
     // t->vfs=fat;
     fat->root = t;
     t->TYPE |= FileType::__DIR;
     t->TYPE |= FileType::__VFS;
     t->TYPE |= FileType::__ROOT;

     t->RefCount += 100;

     // FAT32FILE * STDIN = new FAT32FILE(a, ".STDIN");
     // FAT32FILE *STDOUT = new FAT32FILE(a, ".STDOUT");
     // FAT32FILE *STDERR = new FAT32FILE(a, ".STDERR");

     a.high_clus = fat->Dbr.root_clus >> 4;
     a.low_clus = fat->Dbr.root_clus;
     t->clus = fat->Dbr.root_clus;

     // STDIN->TYPE|=FAT32FILE::__SPECICAL;
     // STDERR->TYPE|=FAT32FILE::__SPECICAL;
     // STDOUT->TYPE|=FAT32FILE::__SPECICAL;

     // STDIN->ref++;
     // STDOUT->ref++;
     // STDERR->ref++;

     root = t;
     kout << "OpenedFile->clus" << (void*)t->clus << endl;
     root->pre = root->child = root->parent = root->next = nullptr;
  */
    // OpenedFile->next=STDIN;
    // STDIN->next=STDOUT;
    // STDOUT->next=STDERR;
    // STDERR->next=nullptr;
    // STDERR->pre=STDOUT;
    // STDOUT->pre=STDIN;
    // STDIN->pre=OpenedFile;
    /*
        FileNode * dev=new FileNode;
        dev->parent=root;
        dev->TYPE|=FileType::__DIR;
        dev->RefCount=1000;
        dev->name=new char[20];
        strcpy(dev->name,"dev");

        UartFile * tty=new UartFile;
        tty->parent=dev;
        tty->TYPE|=FileType::__DEVICE;
        tty->RefCount=1000;
     */
/*     
    FileNode * dev=new FileNode;
    dev->name=new char[10];
    strcpy(dev->name,"dev");
    dev->parent=root;
    root->child=dev;
    dev->TYPE|=__DIR;
    dev->RefCount+=10;

    UartFile * tty=new UartFile;
    tty->name=new  char[10];
    strcpy(tty->name,"tty");
    tty->parent=dev;
    dev->child=tty;
    tty->TYPE|=__DEVICE;
    tty->RefCount+=10;
    tty->setFakeDevice(true);
 */

    STDIO = new UartFile();

    return true;
}

FileNode* VFSM::get_root()
{
    return root;
}

bool VFSM::destory()
{

    ext4_cache_write_back("/", 0);

    int r = ext4_journal_stop("/");
    if (r != EOK) {
        kout << "ext4_journal_stop: fail " << r << endl;
    }

    r = ext4_umount("/");
    if (r != EOK) {
        kout << "ext4_umount: fail " << r << endl;
    }
}

void VFSM::get_file_path(FileNode* file, char* ret)
{
    if (file == root) {
        ret[1] = '\0';
        ret[0] = '/';
        return;
    }

    get_file_path(file->parent, ret);

    strcat(ret, "/");
    strcat(ret, file->get_name());

    return;
}

void VFS::get_file_path(FileNode* file, char* ret)
{
    if (file == root) {
        ret[1] = '\0';
        ret[0] = '/';
        return;
    }

    get_file_path(file->parent, ret);

    // strcat(ret, "/");
    strcat(ret, file->get_name());
    strcat(ret, "/");

    return;
}

// 只能打开已经打开的文件，说实话，我都不知道这东西有啥用，但是好像有很多地方在用
FileNode* VFSM::find_file_by_path(const char* path, bool& isOpened)
{
    if (path[0] == '/' && path[1] == 0) {
        isOpened = true;
        return get_root();
    }

    char* path_ = new char[512];
    unified_file_path(path, path_);
    const char* path1 = (const char*)path;
    char* sigleName = new char[100];
    FileNode* re;
    FileNode* t = get_root();
    FileNode* child = t->child;
    bool isFind = 0;
    while ((path1 = split_path_name(path1, sigleName)) != nullptr) {
        isFind = 0;
        child = t->child;
        while (child != nullptr) {
            if (strcmp(child->get_name(), sigleName) == 0) {
                isFind = true;
                break;
            }
            child = child->next;
        }

        if (isFind) {
            t = child;
        }
        /*   else if (t->TYPE == FileType::__VFS) {
             re = t->vfs->open(path1);
             delete[] sigleName;
             delete[] path1;
             return re;
         } */
        else {
            delete[] sigleName;
            delete[] path1;
            return nullptr;
        }
    }
    delete[] sigleName;
    delete[] path1;
    isOpened = true;
    return t;
}

void VFSM::showRootDirFile()
{
}

void FileNode::show()
{
    kout[Info] << "name " << name << endl
               << "size " << fileSize << endl;
}
FileNode* VFSM::open(const char* path, const char* cwd)
{
    bool a;
    // IntrSave(a);

    // kout[Info] << " VFSM::open0 " << path << " cwd " << cwd << endl;
    // IntrRestore(a);

    char* pathsrc = new char[512];
    strcpy(pathsrc, path);
    char* path_ = new char[512];
    path_[0] = 0;
    // IntrSave(a);

    // kout[Info] << "VFSM " << pathsrc << " " << cwd << endl;
    unified_path(pathsrc, cwd, path_);
    const char* path1 = (const char*)path_;
    // unified_file_path(pathsrc, path1);
    kout[Info] << "VFSM::open1 " << path1<<endl;

     if (path1[0] == '/' && path1[1] == 0) {
        root->RefCount++;
        return get_root();
    }

   // IntrRestore(a);

    char* sigleName = new char[100];
    FileNode* re;
    FileNode* t = get_root();
    FileNode* child = t->child;
    bool isFind = 0;
    path1++;
    while ((path1 = split_path_name(path1, sigleName)) != nullptr) {
        kout<<path1<<endl;
        isFind = 0;
        child = t->child;
        while (child != nullptr) {
            kout[DeBug]<<"sigleName "<<sigleName<<" child "<<child->get_name()<<endl;
            if (strcmp(child->get_name(), sigleName) == 0) {
                isFind = true;
                break;
            }
            child = child->next;
        }

        if (isFind) {
            t = child;
        } else if (t->TYPE & FileType::__VFS) {
            // kout[Info] << "find VFS" << endl;
            re = t->vfs->open(path1, t);
            delete[] sigleName;
            delete[] path1;
            // while (*path) {
            // kout[Info] <<(int)*path << endl;
            // path++;
            // }

            if (re == nullptr) {
                kout[Warning] << "can't open " << path << endl;
            }

            return re;
        } else {
            kout[Warning] << "can't find VFS" << endl;
            delete[] sigleName;
            delete[] path1;
            delete[] pathsrc;
            return nullptr;
        }
    }
    delete[] sigleName;
    delete[] pathsrc;
    delete[] path1;
    FileNode* r = t; // 如果能成功打开，则路径上的文件的引用计数都要+1
    while (r != get_root()) {
        kout[Info] << "open " << r->name <<"parent"<<r->parent<< endl;
        r->RefCount++;
        r = r->parent;
    }
    root->RefCount++;
    // kout[Info]<<"VFMS::open "<<t->name<< " success"<<endl;
    return t;
}

void VFSM::close(FileNode* t)
{
    if (t->TYPE == FileType::__PIPEFILE||t->TYPE==FileType::__DEVICE) {
        return;
    }

    kout[DeBug]<<" VFSM::close "<<t->get_name()<<endl;
/*     if (t==root) {
    
    kout[Warning]<<" VFSM::close "<<endl;
    }
 */
    FileNode* r = t; // 将路径上的所有文件节点引用计数--，如果为零则关闭删除节点
    FileNode* tmp = nullptr;
    while (r != get_root()) {
        r->RefCount--;
        tmp = r;
        r = r->parent;
        if (tmp->RefCount == 0) {
            if (tmp->parent == nullptr) {
                kout[Error] << "VFSM::Close parent is nullptr " << endl;
            }
            if (tmp->parent->child == tmp) { // 当tmp为第一个孩子
                tmp->parent->child = tmp->next;
            } else { // tmp有pre的情况
                if (tmp->pre == nullptr) {
                    kout[Error] << "VFSM::Close pre is nullptr " << endl;
                } else {
                    tmp->pre->next = tmp->next;
                }
            }
            if (tmp->next) {
                tmp->next->pre = tmp->pre;
            }
            kout[Info] << "close " << tmp->name << endl;
            delete tmp;
        }
    }
    root->RefCount--;
}

/*     Uint64 len = strlen(path);
    bool isOpened;
    char* rpath = unified_path(path, cwd);
    kout << "Create FILE  " << rpath << endl;

    FAT32FILE *t, *re;
    t = find_file_by_path(rpath, isOpened);
    if (!t) {
        kout[Fault] << "can't find dir" << endl;
        return false;
    }
    // t->show();
    kout << path << ' ' << cwd << ' ' << fileName << endl;
    re = t->fat->create_file(t, fileName, type);
    if (!re) {
        kout[Fault] << "failed create file" << endl;
        return false;
    }
    // t->fat->show_empty_clus(2);
    // re->show();

    rpath[len + 1] = 0;
    rpath[len] = '/';
    strcat(rpath, fileName);
    re->path = rpath;

    // re->show();
    return true;

 */

bool VFSM::create_file(const char* path, const char* cwd, char* fileName, Uint64 type)
{
    FileNode* dir;
    dir = open(path, cwd);
    if (dir == nullptr) {
        kout[Error] << "VFSM::create_file dir is nullptr" << endl;
        return false;
    }
    FileNode* file;
    file = dir->vfs->create_file(dir, fileName);
    if (file == nullptr) {
        kout[Error] << "VFSM::create_file file can't create" << endl;
        return false;
    }
    close(dir);
    return true;
}

bool VFSM::create_dir(const char* path, const char* cwd, char* dirName)
{
    FileNode* dir;
    dir = open(path, cwd);
    if (dir == nullptr) {
        kout[Error] << "VFSM::create_dir dir is nullptr" << endl;
        return false;
    }
    FileNode* file;
    file = dir->vfs->create_dir(dir, dirName);
    if (file == nullptr) {
        kout[Error] << "VFSM::create_dir dirfile can't create" << endl;
        return false;
    }
    close(dir);
    return true;
}

bool VFSM::del_file(const char* path, const char* cwd)
{
    FileNode* file;
    file = open(path, cwd);
    if (file == nullptr) {
        kout[Error] << "VFSM::del_file dir is nullptr" << endl;
        return false;
    }
    file->vfs->del(file);
    if (file->RefCount == 1) {
        close(file);
    }
    return true;
}

FileNode* VFSM::open(FileNode* file)
{
    FileNode* r = file;
    while (r != get_root()) {
        r->RefCount++;
        r = r->parent;
    }
    root->RefCount++;
    return file;
}

void VFSM::show_all_opened_child(FileNode* tar, bool r)
{
    FileNode* t;
    kout[Info] << "show all opened child" << endl;
    ASSERTEX(tar, "VFSM::show_all_opened_child t is a nullptr");
    t = tar->child;
    while (t) {
        ASSERTEX(t, "VFSM::show_all_opened_child t is a nullptr");
        t->show();
        if (r) {
            show_all_opened_child(t, 1);
        }
        t = t->next;
    }
}
/*
    int k = strlen(ref_path);
    while (ref_path[--k] != '/')
        ;
    char* file_name = new char[200];
    char* file_path = new char[200];
    strcpy(file_name, &ref_path[k + 1]);
    file_path[k] = 0;
    FAT32FILE *from, *to;
    create_file(file_path, cwd, file_name);
    from = open(ref_path, cwd);
    from->show();
    to = open(srcpath, cwd);
    to->show();

    from->table.low_clus = to->table.low_clus;
    from->table.high_clus = to->table.high_clus;
    from->table.size = to->table.size;
    from->clus = to->clus;
    from->fat = to->fat;

    delete[] file_name;
    delete[] file_path;
    close(from);
    close(to);
    return true;
 */

bool VFSM::link(const char* srcpath, const char* ref_path, const char* cwd)
{
    kout[Info] << "VFSM::link isn't finish" << endl;
    return true;
}

/*

    bool isOpened;
    // kout[yellow]<<"yes"<<endl;
    char* rpath = unified_path(path, cwd);
    FAT32FILE *t, *re;
    t = find_file_by_path(rpath, isOpened);
    // t->show();
    if (isOpened) {
        kout[Fault] << "file isn't close" << endl;
        return false;
    }
    return t->fat->unlink(t); */

bool VFSM::unlink(const char* path, const char* cwd)
{
    kout[Info] << "VFSM::unling isn't finish" << endl;
    return true;
}

bool VFSM::unlink(char* abs_path)
{
    kout[Info] << "VFSM::unling isn't finish" << endl;
    return true;
}

bool IsFile(FileNode* t)
{
    return t->TYPE == 0;
}

VFSM vfsm;