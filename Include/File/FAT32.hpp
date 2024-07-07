#ifndef _FAT32_HPP__
#define _FAT32_HPP__

// #include <ramdisk_driver.hpp>
#include "Synchronize/Synchronize.hpp"
#include <Types.hpp>
#include <Library/KoutSingle.hpp>
#include <Library/Pathtool.hpp>
#include <Library/Kstring.hpp>
#include <Driver/VirtioDisk.hpp>

class DISK;
extern DISK Disk;
struct DBR
{
    Uint32 FAT_num;
    Uint32 FAT_sector_num;
    Uint32 sector_size;
    Uint32 clus_sector_num;
    Uint32 rs_sector_num;
    Uint32 all_sector_num;
    Uint32 root_clus;
    Uint32 clus_size;
};

union FATtable
{

    enum :Uint8
    {
        READ_ONLY = 0x1 << 0,
        HIDDEN = 0x1 << 1,
        SYSTEM = 0x1 << 2,
        VOLUME_LABEL = 0x1 << 3,
        SUBDIRENCTORY = 0x1 << 4,
        FILE = 0x1 << 5,
        DEVICE = 0x1 << 6,
    };
    struct
    {
        char name[8];

        Uint8 ex_name[3];
        Uint8 type;
        Uint8 rs;
        Uint8 ns;
        Uint8 S_time[2]; // 创建时间

        Uint8 S_date[2];
        Uint8 C_time[2]; // 访问时间
        Uint16 high_clus;
        Uint8 M_time[2]; // 修改时间

        Uint8 M_date[2];
        Uint16 low_clus;
        Uint32 size;
    };
    struct
    {
        Uint8 attribute;
        Uint8 lname0[10];
        Uint8 type1;
        Uint8 rs2;
        Uint8 check;
        Uint8 lname1[12];
        Uint16 clus1;
        Uint8 lname2[4];
    };

    Sint32 get_name(char* REname); // 返回值为-1时说明无效，0为短名称，大于1的序列为长名称(长名称无法完成拷贝),-2为点目录
    FATtable()
    {

    }
};
bool ALLTURE(FATtable* t);
bool VALID(FATtable* t);
bool EXCEPTDOT(FATtable* t);
class FAT32;
class VFSM;




class FAT32FILE
{
public:
    enum : Uint32
    {
        __DIR = 1ull << 0,
        __ROOT = 1ull << 1,
        __VFS = 1ull << 2,
        __DEVICE = 1ull << 3,
        __TEMP = 1ull << 4,
        __LINK = 1ull << 5,
        __SPECICAL = 1ull << 6,
        __PIPEFILE = 1ull << 7,
    };
    char* name = nullptr;
    Uint32 TYPE;
    FATtable table;
    Uint64 table_clus_pos;
    Uint64 table_clus_off;
    Uint32 clus;

    FAT32FILE* next = nullptr;
    FAT32FILE* pre = nullptr;

    FAT32* fat;
    Uint64 ref;
    char* path;


    FAT32FILE(FATtable tb, char* lName, Uint64 _clus = 0, Uint64 pos = 0, char* path = nullptr);
    ~FAT32FILE();
    bool set_path(char* _path);

    Sint64 read(unsigned char* buf, Uint64 size);
    Sint64 read(unsigned char* buf, Uint64 pos, Uint64 size);
    bool write(unsigned char* src, Uint64 size);
    bool write(unsigned char* src, Uint64 pos, Uint64 size);


    void show();
};


class PIPEFILE: public FAT32FILE
{
public:

    PIPEFILE();
    ~PIPEFILE();

    enum:Uint32
    {
        FILESIZE=1<<12,
    } ;

    Uint32 readRef;
    Uint32 writeRef;
    Uint32 in,out;
    Uint8 data[FILESIZE];
    Semaphore *file,*full,*empty;
    Sint64 read(unsigned char* buf, Uint64 pos, Uint64 size);
    bool write(unsigned char* src, Uint64 size);


    void show();
};


class FAT32
{
    friend class FAT32FILE;
    friend class VFSM;

private:
    Uint64 DBRlba;
    Uint64 FAT1lba;
    Uint64 FAT2lba;
    Uint64 DATAlba;


    // char  cache[4096];

public:
    DBR Dbr;//fat原始信息记录
    Uint64 clus_to_lba(Uint64 clus);//clus号和lba互相转化
    Uint64 lba_to_clus(Uint64 lba);


    bool get_clus(Uint64 clus, unsigned char* buf);//获取簇中的数据
    bool get_clus(Uint64 clus, unsigned char* buf, Uint64 start, Uint64 end);
    bool set_clus(Uint64 clus, unsigned char* buf);//设置簇
    bool set_clus(Uint64 clus, unsigned char* buf, Uint64 start, Uint64 end);
    bool clear_clus(Uint64 clus);
    bool show_empty_clus(Uint64 clus);//Debug用，测试簇中空虚的FATTABLE

    Uint64 find_empty_clus();//查找空簇,主要是遍历fat1
    bool set_table(FAT32FILE* file);//从文件到fatTable
    Uint32 get_next_clus(Uint32 clus);
    bool set_next_clus(Uint32 clus, Uint32 nxt_clus);//为簇设置下一个簇


    bool init();
    FAT32();
    ~FAT32();
    FAT32FILE* find_file_by_path(char* path);
    FAT32FILE* get_child_form_clus(char* child_name, Uint64 src_lba); // 从文件夹簇中读取出fat32file文件对象
    FAT32FILE* open(char* path);
    bool close(FAT32FILE* p);
    bool link();
    bool unlink(FAT32FILE* file);
    FAT32FILE* create_file(FAT32FILE* dir, char* fileName, Uint8 type = FATtable::FILE);
    FAT32FILE* create_dir(FAT32FILE* dir, char* fileName);
    bool del_file(FAT32FILE* file);                                                                        // 可用于删除文件夹
    FAT32FILE* get_next_file(FAT32FILE* dir, FAT32FILE* cur = nullptr, bool (*p)(FATtable* temp) = VALID); // 获取到的dir下cur的下一个满足p条件的文件，如果没有则返回空
};

#endif