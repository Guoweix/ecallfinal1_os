// #include "File/lwext4_include/ext4.h"
#include "vfsm.hpp"
#include <File/lwext4_include/ext4.h>
#include "Library/KoutSingle.hpp"
#include "Memory/pmm.hpp"
#include "Memory/vmm.hpp"
#include "Types.hpp"

class EXT4;
// struct ext4_file;
// struct ext4_dir;

class ext4node : public FileNode{

public:

    ext4_file fp;
    ext4_dir  fd;
    Sint64 offset;

    void initlink(ext4_file tb,const char* Name,EXT4 * fat_);
    void initfile(ext4_file tb, const char* Name,EXT4 * fat_);
    void initdir(ext4_dir tb,const char* Name,EXT4 * fat_);
    
    bool set_name(char* _name) override;//
    Sint64 read(void* dst, Uint64 pos, Uint64 size)override;//
    Sint64 read(void* dst,  Uint64 size)override;//
    Sint64 write(void* src, Uint64 pos, Uint64 size)override;//
    Sint64 write(void* src, Uint64 size)override;//

    //bool del();//这个我看fat32也没有实现，而是实现vfs的del，所以我也先空着了

    void show();//
    ext4node(){
        // kout<<"ext4node create"<<endl;
    };
    ~ext4node(){};
};

class EXT4:public VFS{
    friend class ext4node;
    friend class VFSM;
public:
    char* FileSystemName() {return nullptr;};
    void show_all_file_in_dir(ext4node * dir,Uint32 level=0);//
    FileNode** get_all_file_in_dir(FileNode* dir, bool (*p)(FileType type)) override{
        return nullptr;
    };//
    ext4node* open(const char* _path, FileNode* parent) override;//
    ext4node* get_node(const char* path) override{
        return nullptr;
    };
    bool close(FileNode* p) override{
        return true;
    };//
    bool del(FileNode* file) override; 
                                       
    ext4node* create_file(FileNode* dir_, const char* fileName, FileType type = FileType::__FILE) override;//
    ext4node* create_dir(FileNode* dir_, const  char* fileName) override;//
    
    bool init(){return 1;};//

    void get_next_file(ext4node* dir, ext4node* cur,ext4node* tag);//
    EXT4(){};
    ~EXT4(){};
};

extern Uint32 EXT;