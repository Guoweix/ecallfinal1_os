#include "vfsm.hpp"
#include "ext4.h"
#include "Library/KoutSingle.hpp"
#include "Memory/pmm.hpp"
#include "Memory/vmm.hpp"
#include "Types.hpp"

class ext4node : public FileNode{

public:

    ext4_file fp;
    ext4_dir  fd;

    void initfile(ext4_file tb, char* Name,EXT4 * fat_);
    void initdir(ext4_dir tb, char* Name,EXT4 * fat_);
    
    bool set_name(char* _name);
    Sint64 read(void* dst, Uint64 pos, Uint64 size);
    Sint64 read(void* dst,  Uint64 size);
    Sint64 write(void* src, Uint64 pos, Uint64 size);
    Sint64 write(void* src, Uint64 size);

    //bool del();//这个我看fat32也没有实现，而是实现vfs的del，所以我也先空着了

    void show();
    ext4node(){};
    ~ext4node(){};
};

class EXT4:public VFS{
    friend class ext4node;
    friend class VFSM;
public:
    char* FileSystemName() {};
    void show_all_file_in_dir(ext4node * dir,Uint32 level=0);//
    FileNode** get_all_file_in_dir(FileNode* dir, bool (*p)(FileType type)) override;//
    ext4node* open(char* path, FileNode* parent) override;//
    ext4node* get_node(const char* path) override;
    bool close(FileNode* p) override;//
    bool del(FileNode* file) override; 
                                       
    ext4node* create_file(FileNode* dir_, char* fileName, FileType type = FileType::__FILE) override;//
    ext4node* create_dir(FileNode* dir_, char* fileName) override;//
    
    bool init();

    void get_next_file(ext4node* dir, ext4node* cur,ext4node* tag);
    EXT4(){};
    ~EXT4(){};
};