#include "Library/KoutSingle.hpp"
#include "Types.hpp"
#include <File/FAT32.hpp>
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

    kout[Error] << "FileNode::read " << endl;
    return false;
}

Sint64 FileNode::read(void* dst,Uint64 size)
{

    kout[Error] << "FileNode::read " << endl;
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
    if (parent != nullptr) {
        if (parent->child == this)
            parent->child = next;
    }
}

bool VFSM::init()
{
    FAT32* fat = new FAT32;
    FATtable a;
    a.size = 0;
    FAT32FILE* t;
    t = new FAT32FILE(a, ".ROOT",fat);
    kout[Info]<<"FAT32 "<<(void *)fat<<endl;
    // t->vfs=fat;
    fat->root=t;
    t->TYPE|=FileType::__DIR;
    t->TYPE|=FileType::__VFS;
    t->TYPE|=FileType::__ROOT;


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

    // OpenedFile->next=STDIN;
    // STDIN->next=STDOUT;
    // STDOUT->next=STDERR;
    // STDERR->next=nullptr;
    // STDERR->pre=STDOUT;
    // STDOUT->pre=STDIN;
    // STDIN->pre=OpenedFile;

    return true;
}

FileNode* VFSM::get_root()
{
    return root;
}
bool VFSM::destory()
{
}

/*

    if (path[0] == '/' && path[1] == 0) {
        isOpened = true;
        return get_root();
    }

    isOpened = false;
    FAT32FILE* t;
    t = (FAT32FILE *)root;
    char* cpath = path;
    while (t != nullptr) {
        if (cpath = pathcmp(path, t->path)) {
            if (*cpath == '\0') {
                isOpened = true;
                return t;
            } else if (t->TYPE & (FAT32FILE::__DIR) && (t->TYPE & FAT32FILE::__VFS)) {
                return t->vfs->find_file_by_path(cpath);
            }
        }
        ASSERTEX(t != t->next, "LinkTable loop found in " << __FILE__ << " " << __LINE__);
        t = t->next;
    }
    // 当链表中均不存在该文件时，从根目录下开始搜索

    t = OpenedFile->fat->find_file_by_path(path);
    if (t)
        t->path = path;
    else

        return t;
 */
void VFSM::get_file_path(FileNode* file, char* ret)
{
    if (file == root)
        return;

    get_file_path(file->parent, ret);
    strcat(ret, "/");
    strcat(ret, file->get_name());

    return;
}

// 只能打开已经打开的文件，说实话，我都不知道这东西有啥用，但是好像有很多地方在用
FileNode* VFSM::find_file_by_path(char* path, bool& isOpened)
{
    if (path[0] == '/' && path[1] == 0) {
        isOpened = true;
        return get_root();
    }

    char* path1 = new char[512];
    unified_file_path(path, path1);
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

/* {

    bool isOpened;

    char* rpath = unified_path(path, cwd);
    // char* rpath = unified_path("", cwd);

    kout << Green << rpath << " " << path << " " << cwd << endl;

    FAT32FILE* t;
    t = find_file_by_path(rpath, isOpened);

    if (isOpened)
        return t;

    if (t == nullptr) {
        kout[Warning] << "file can't find" << endl;
        return nullptr;
    }
    t->next = OpenedFile->next;
    t->pre = OpenedFile;
    OpenedFile->next = t;
    if (t->next)
        t->next->pre = t;
    kout << "A5" << endl;

    t->ref++;
    kout << "A5" << endl;
    return t;

} */

FileNode* VFSM::open(const char* path, char* cwd)
{

    if (path[0] == '/' && path[1] == 0) {
        root->RefCount++;
        return get_root();
    }

    char* pathsrc = new char[512];
    strcpy(pathsrc, path);
    char* path1 = new char[512];
    unified_file_path(pathsrc, path1);
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
        } else if (t->TYPE == FileType::__VFS) {
            re = t->vfs->open(path1, t);
            delete[] sigleName;
            delete[] path1;
            return re;
        } else {
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
        r->RefCount++;
        r = r->parent;
    }
    root->RefCount++;
    return t;
}
void VFSM::close(FileNode* t)
{

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

            delete tmp;
        }
    }
    root->RefCount--;
}

void VFSM::show_opened_file()
{
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

bool VFSM::create_file(const char* path, char* cwd, char* fileName, Uint64 type)
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

bool VFSM::create_dir(const char* path, char* cwd, char* dirName)
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

bool VFSM::del_file(const char* path, char* cwd)
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
/*
FileNode* VFSM::get_next_file(FileNode* dir, FileNode* cur, bool (*p)(FATtable* temp))
{
    // kout<<"get_next_file"<<endl;
    FAT32FILE* t;
    // kout<<Red<<"dir:fat"<<dir->fat<<endl;
    t = dir->vfs->get_next_file(dir, cur, p);
    // kout<<Green<<"dir:fat"<<dir->fat<<endl;

    // kout<<"~get_next_file"<<endl;
    if (t == nullptr) {
        return nullptr;
    }
    t->path = new char[200];
    if (dir != get_root()) {
        strcpy(t->path, dir->path);
        strcat(t->path, "/");
    } else
        strcpy(t->path, "/");

    strcat(t->path, t->name);
    t->fat = dir->fat;
    // kout<<Red<<t->fat<<endl;
    return t;
} */
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

bool VFSM::link(const char* srcpath, const char* ref_path, char* cwd)
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

bool VFSM::unlink(const char* path, char* cwd)
{

    kout[Info] << "VFSM::unling isn't finish" << endl;
    return true;
}

bool VFSM::unlink(char* abs_path)
{
    /*     bool isOpened;
        // kout[yellow]<<"yes"<<endl;
        // char* rpath = unified_path(path, cwd);
        FAT32FILE *t, *re;
        t = find_file_by_path(abs_path, isOpened);
        // t->show();
        if (isOpened) {
            kout[Fault] << "file isn't close" << endl;
            return false;
        }
        return t->fat->unlink(t); */

    kout[Info] << "VFSM::unling isn't finish" << endl;
    return true;
}

// ErrorType MemapFileRegion::Save() // Save memory to file
// {
//     VirtualMemorySpace* old = VirtualMemorySpace::Current();
//     VMS->Enter();
//     VMS->EnableAccessUser();
//     // Uint64 re=0;
//     kout << Red << "Save" << endl;
//     Sint64 re = File->write((unsigned char*)StartAddr, Offset, Length);
//     VMS->DisableAccessUser();
//     old->Enter();
//     return re >= 0 ? ERR_None : -re; //??
// }
bool IsFile(FileNode* t)
{
    return t->TYPE == 0;
}

VFSM vfsm;