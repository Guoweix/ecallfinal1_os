#ifndef __VFSM_HPP__
#define __VFSM_HPP__

// #include "File/FileObject.hpp"
#include "Library/KoutSingle.hpp"
#include "Memory/pmm.hpp"
#include "Memory/vmm.hpp"
#include "Types.hpp"
// #include <File/FAT32.hpp>
#include <Library/Kstring.hpp>

inline const char* INVALIDPATHCHAR()
{
    return "/\\:*?\"<>|";
}

bool IsFile(void* t);

class VFS;
class VFSM;
struct file_object;

enum FileType : Uint64 {
    __FILE = 0,
    __DIR = 1ull << 0,
    __ROOT = 1ull << 1,
    __VFS = 1ull << 2,
    __DEVICE = 1ull << 3,
    __TEMP = 1ull << 4,
    __LINK = 1ull << 5,
    __SPECICAL = 1ull << 6,
    __PIPEFILE = 1ull << 7,
};

class FileNode {
    friend class VFS;

public:
    char* name = nullptr;
    VFS* vfs = nullptr;
    Uint64 TYPE;
    Uint64 flags;
    FileNode *parent = nullptr,
             *pre = nullptr,
             *next = nullptr,
             *child = nullptr;

    Uint64 fileSize = 0;
    Uint32 RefCount = 0;

    void set_parent(FileNode* _parent); // 只改变树结构而不改变实际存储结构
    // Uint64 get_path_len(Uint8 _flag); // 为1时为vfs路径长度，为0时为全局路径长度
    // char* get_path_copy(char* dst, Uint8 _flag);

    virtual Sint64 read(void* dst, Uint64 pos, Uint64 size);
    virtual Sint64 read(void* dst,  Uint64 size);
    virtual Sint64 write(void* src, Uint64 pos, Uint64 size);
    virtual Sint64 write(void* src, Uint64 size);
    virtual Sint64 size();
    virtual bool ref(file_object* f);
    virtual bool unref(file_object* f);
    virtual const char* get_name();
    virtual bool set_name(char* _name);
    // virtual char* get_path(Uint8 _flag); //_flag=0 绝对路径   1 vfs路径
    virtual bool IsDir();
    virtual bool del();

    virtual void show();
    // FileNode(VFS* _VFS, Uint64 _flags);
    FileNode() { name=new char[100];};
    virtual ~FileNode();
};

class VFS {

public:
    FileNode* root;

    virtual char* FileSystemName() {};
    VFS() {};
    virtual ~VFS() {};

    virtual FileNode* open(char* path, FileNode* parent) = 0;
    virtual bool close(FileNode* p) = 0;

    virtual FileNode* create_file(FileNode* dir, char* fileName, FileType type = FileType::__FILE) = 0;
    virtual FileNode* create_dir(FileNode* dir, char* fileName) = 0;
    // 返回一个fileNode列表，其中是所有满足文件类型的文件
    virtual FileNode** get_all_file_in_dir(FileNode* dir, bool (*p)(FileType type)) = 0;

    virtual FileNode* get_node(const char* path) = 0;
    virtual bool del(FileNode* p) = 0;
};

class VFSM {
private:
    FileNode* root;

    FileNode* find_file_by_path(char* path, bool& isOpened);//返回一个孤立的FileNode,

public:
    FileNode* open(const char* path, char* cwd);
    FileNode* open(FileNode* file);
    void close(FileNode* t);
    

    void showRootDirFile();
    bool create_file(const char* path, char* cwd, char* fileName, Uint64 type = FileType::__FILE);
    bool create_dir(const char* path, char* cwd, char* dirName);
    bool del_file(const char* path, char* cwd);
    bool link(const char* srcpath, const char* ref_path, char* cwd); // ref_path为被指向的文件
    bool unlink(const char* path, char* cwd);
    bool unlink(char* abs_path);
    // FileNode* get_next_file(FileNode* dir, FileNode* cur = nullptr, bool (*p)(void* temp) = IsFile); // 获取到的dir下cur的下一个满足p条件的文件，如果没有则返回空

    void get_file_path(FileNode* file, char* ret);
    // void show_opened_file();
    void show_all_opened_child(FileNode * tar,bool r);//r为1表示递归显示，为0表示只显示一层
    // void show_all_opened_child(FileNode* tar, bool r)
    bool init();
    bool destory();
    FileNode* get_root();
};

extern VFSM vfsm;
// class VFSM
// {
// private:
//     FileNode *root;
//     bool add_new_node(FileNode *p, FileNode *parent); // 只改变对应树的结构未改变对应存储方式
//     FileNode *find_child_name(FileNode *p, const char *name);//在子节点中查找对应名字的文件节点

// public:
//     bool is_absolutepath(char *path);
//     FileNode * create_directory(char *path);
//     FileNode * create_file(char *path); // 目前只支持VFS中的新建，即/VFS/*
//     bool move(char *src, char *dst);
//     bool copy(char *src, char *dst);
//     bool del(char *path);
//     bool load_vfs(VFS* vfs,char * path);
//     // FileNode *find_vfs(char *path, char *&re);
//     // FileNode *find_vfs(char *path);
//     FileNode * get_node(char * path);

//     bool Init();
//     bool Destroy();
// };
// extern VFSM vfsm;



#endif