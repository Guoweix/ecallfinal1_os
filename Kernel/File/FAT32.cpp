#include "Driver/VirtioDisk.hpp"
#include "File/vfsm.hpp"
#include "Library/KoutSingle.hpp"
#include "Synchronize/Synchronize.hpp"
#include "Types.hpp"
#include <File/FAT32.hpp>

// char cache[512];

FileNode** FAT32::get_all_file_in_dir(FileNode* dir, bool (*p)(FileType type))
{
    // FileNode ** re=new FileNode* [100];

    return nullptr;
}

FAT32FILE* FAT32::get_node(const char* path)
{
    kout[Error] << "FAT32::get_node" << endl;
    return nullptr;
}

FAT32FILE::FAT32FILE(FATtable ft,const char* lName, FAT32* fat_, Uint64 _clus, Uint64 pos, char* _path)
{

    // kout << Yellow << "FAT32FILE" << endl;
    table = ft;
    clus = table.low_clus | (table.high_clus << 16);

    vfs = fat_;
    fileSize = table.size;
    TYPE = 0;
    TYPE |= table.type & 0x10 ? 1 : 0;

    if (lName) {
        name = new char[strlen(lName) + 1];
        strcpy(name, lName);
    }
    table_clus_pos = _clus;
    table_clus_off = pos;
}
bool FAT32::unlink(FAT32FILE* file)
{
    FATtable* p = (FATtable*)new unsigned char[Dbr.clus_size];
    get_clus(file->table_clus_pos, (unsigned char*)p);

    Uint64 k = file->table_clus_off;
    p[k].type1 = 0x0f;
    while (p[k].attribute != 0xe5 && p[k].type1 == 0x0f) {
        p[k].attribute = 0xe5;
        k--;
    }
    set_clus(file->table_clus_pos, (unsigned char*)p);

    Uint64 rclus = file->clus;
    Uint64 nxt;

    delete[] p;
    return true;
}

FAT32FILE::~FAT32FILE()
{
}
/*
bool FAT32FILE::set_path(char* _path)
{
    path = new char[100];
    strcpy(path, _path);
    return true;
} */

Sint32 FATtable::get_name(char* REname)
{
    int i;
    if (name[0] == 0 || name[0] == 0xe5)
        return -1;
    else if (type == 0x0F) {
        int j = 0;
        i = 0;
        while (i < 10) {
            REname[j] = lname0[i];
            j++;
            i++;
        }
        i = 0;

        while (i < 12) {
            REname[j] = lname1[i];
            j++;
            i++;
        }
        i = 0;

        while (i < 4) {
            REname[j] = lname2[i];
            j++;
            i++;
        }

        return attribute;
    } else if (name[0] == 0x2e) {
        return -2;
    } else if (name[0] != 0xe5) {
        for (i = 0; i < 8; i++) {
            if (name[i] != ' ')
                REname[i] = name[i];
            else
                break;
        }
        if (ex_name[0] != ' ') {
            REname[i++] = '.';
            REname[i++] = ex_name[0];
            REname[i++] = ex_name[1];
            REname[i++] = ex_name[2];
        }
        REname[i] = 0;

        return 0;
    }
}

bool FAT32::init()
{
    kout << Yellow << "FAT32::init" << endl;

    Disk.DiskInit();

    unsigned char* buf = new unsigned char[512];
    Disk.readSector(0, (Sector*)buf);
    if (!((Uint8)buf[510] == 0x55 && (Uint8)buf[511] == 0xAA)) {
        kout << "MBR read false" << endl;
        return false;
    }
    DBRlba = (buf[0x1c9] << 24) | (buf[0x1c8] << 16) | (buf[0x1c7] << 8) | (buf[0x1c6]);

    Disk.readSector(DBRlba, (Sector*)buf);
    if (buf[510] != 0x55 || buf[511] != 0xaa) {
        kout[Fault] << "diskpart error" << endl;
        return false;
    }

    Dbr.sector_size = buf[0xb] | (buf[0xc] << 8);
    Dbr.clus_sector_num = buf[0xd];
    Dbr.rs_sector_num = buf[0xe] | (buf[0xf] << 8);
    Dbr.FAT_num = buf[0x10];
    Dbr.all_sector_num = buf[0x20] | (buf[0x21] << 8) | (buf[0x22] << 16) | (buf[0x23] << 24);
    Dbr.FAT_sector_num = buf[0x24] | (buf[0x25] << 8) | (buf[0x26] << 16) | (buf[0x27] << 24);
    Dbr.root_clus = buf[0x2c] | (buf[0x2d] << 8) | (buf[0x2e] << 16) | (buf[0x2f] << 24);
    Dbr.clus_size = Dbr.clus_sector_num * Dbr.sector_size;

    // kout<<Red<<"root_clus"<<(void *)Dbr.root_clus<<endl;

    // kout << DataWithSizeUnited(buf, 512, 32) << endl;

    // DBRlba = 0;
    FAT1lba = Dbr.rs_sector_num + DBRlba;
    FAT2lba = FAT1lba + Dbr.FAT_sector_num;
    DATAlba = FAT1lba + Dbr.FAT_sector_num * Dbr.FAT_num;

    kout[Info] << "Dbr.sector_size     " << Dbr.sector_size << endl;
    kout[Info] << "Dbr.FAT_num         " << Dbr.FAT_num << endl;
    kout[Info] << "Dbr.FAT_sector_num  " << Dbr.FAT_sector_num << endl;
    kout[Info] << "DATAlba             " << DATAlba << endl;
    kout[Info] << "ClusSector          " << Dbr.clus_sector_num << endl;
    kout[Info] << "FAT1lba              " << FAT1lba << endl;
    kout[Info] << "FAT2lba              " << FAT2lba << endl;

    Disk.readSector(DBRlba, (Sector*)buf);
    // for (int i = 0; i < 16; i++)
    //     kout[green] << buf[i] << ' ';
    // kout[green] << endl;

    // kout[yellow] << "FAT1lba             " << FAT1lba << endl;
    Disk.readSector(FAT1lba, (Sector*)buf);
    // for (int i = 0; i < 16; i++)
    //     kout[green] << buf[i] << ' ';
    // kout[green] << endl;

    // kout[yellow] << "FAT2lba             " << FAT2lba << endl;
    Disk.readSector(FAT2lba, (Sector*)buf);
    // for (int i = 0; i < 16; i++)
    //     kout[green] << buf[i] << ' ';
    // kout[green] << endl;

    // kout[yellow] << "DATAlba             " << DATAlba << endl;
    Disk.readSector(DATAlba, (Sector*)buf);
    // for (int i = 0; i < 16; i++)
    //     kout[green] << (char)buf[i] << ' ';
    // kout[green] << endl;

    delete[] buf;
    return true;
}

FAT32::FAT32()
{
    this->init();
}

bool FAT32::get_clus(Uint64 clus, unsigned char* buf)
{
    // kout << Red << "Get Clus" << clus << endl;

    if (clus >= 0xffffff7) {
        kout[Fault] << "can't find clus __" << (void*)clus << endl;
        return false;
    }

    int lba = clus_to_lba(clus);

    // kout << Yellow << lba << endl;
    // for (int i = 0; i < Dbr.clus_sector_num; i++)
    // {
    //     Disk.readSector(lba + i, (Sector*)buf + i * Dbr.sector_size);
    // }

    Disk.readSector(lba, (Sector*)buf, Dbr.clus_sector_num);

    // kout<<Blue<<buf<<endl;
    // kout<<Blue<<DataWithSizeUnited(buf,512,16);

    return true;
}

bool FAT32::get_clus(Uint64 clus, unsigned char* buf, Uint64 start, Uint64 end)
{
    // kout << Red << "Get Clus start end" << clus << endl;
    if (clus >= 0xffffff7) {
        kout[Fault] << "can't find clus addition" << (void*)clus << endl;
        return false;
    }

    int lba = clus_to_lba(clus);

    // for (int i = 0; i < Dbr.clus_sector_num; i++)
    // {
    //     Disk.read(lba + i, buf + i * Dbr.sector_size);
    // }
    Disk.readSector(lba, (Sector*)buf, Dbr.clus_sector_num);

    for (Uint64 i = start; i < end - start; i++) {
        buf[i] = buf[i + start];
    }

    return true;
}

FAT32FILE* FAT32::get_child_form_clus(char* child_name, Uint64 src_clus)
{
    // kout << Red << "Get Child  " << child_name << ' ' << src_clus << endl;
    // kout[blue]<<child_name<<' '<<src_lba<<endl;
    unsigned char* clus = new unsigned char[Dbr.clus_size];
    get_clus(src_clus, clus);
    FATtable* ft = (FATtable*)clus;
    FAT32FILE* re = nullptr;

    Uint32 t;
    Uint32 k;
    char* sName = new char[30];
    sName[26] = 0;
    sName[27] = 0;
    char* lName = new char[100];

    // for (int i = 0; i < 10; i++)
    while (src_clus < 0xffffff8) {
        for (int i = 0; i < Dbr.clus_size / 32; i++) {
            // 旧版
            //  while ((t = ft[i].get_name(sName)) > 0)
            //  {
            //      unicode_to_ascii(sName);
            //      if (t & 0x40)
            //      {
            //          // kout[red]<<"yes"<<endl;
            //          strcpy(&lName[((t & 0xf) - 1) * 13], sName);
            //      }
            //      else
            //          strcpy_no_end(&lName[((t & 0xf) - 1) * 13], sName);
            //      // kout[purple] << sName << ' ' << t << endl;
            //      i++;
            //  }
            // 新版
            while ((t = ft[i].get_name(sName)) > 0) {
                unicode_to_ascii(sName);
                if (t & 0x40) {
                    // kout[red]<<"yes"<<endl;
                    strcpy(&lName[((t & 0xf) - 1) * 13], sName);
                } else
                    strcpy_no_end(&lName[((t & 0xf) - 1) * 13], sName);
                // kout[purple] << sName << ' ' << t << endl;
                i++;
            }

            if (t == -1)
                continue;

            // if (sName[6] != '~' || !isdigit(sName[7]))
            //     strcpy(lName, sName);

            // kout[green] << lName << endl;

            if (strcmp(lName, child_name) == 0 && ft[i].attribute != 0xe5) {
                re = new FAT32FILE(ft[i], lName, this, src_clus, i);
                delete[] sName;
                delete[] clus;
                return re;
            }
        }

        // kout[yellow]<<src_clus<<endl;
        src_clus = get_next_clus(src_clus);
        if (src_clus < 0xffffff8)
            get_clus(src_clus, clus);
    }
    delete[] sName;
    delete[] clus;
    delete[] lName;
    return re;
}

Uint64 FAT32::lba_to_clus(Uint64 lba)
{
    return (lba - DATAlba) / Dbr.clus_sector_num + 2;
}

Uint64 FAT32::clus_to_lba(Uint64 clus)
{
    // kout<<Blue<< Dbr.clus_sector_num<< DATAlba<<endl;
    return (clus - 2) * Dbr.clus_sector_num + DATAlba;
}
/*
FAT32FILE* FAT32::find_file_by_path(char* path)
{
    char* sigleName = new char[50];
    unsigned char* clus = new unsigned char[Dbr.clus_size];
    Uint64 clus_n = Dbr.root_clus;
    FAT32FILE* tb;

    FATtable* ft;
    while ((path = split_path_name(path, sigleName))) {
        // kout[green] << sigleName << endl;
        tb = get_child_form_clus(sigleName, clus_n);
        if (tb == nullptr) {
            // kout[red] << "can't find file:" << sigleName << endl;
            return nullptr;
        }
        if (path[0]) {
            // kout[yellow] << tb->name << endl;
            if (tb->table.type & 0x10) // 目录
            {
                clus_n = tb->table.low_clus | (Uint64)tb->table.high_clus << 16;
                // kout[yellow]<<"dir"<<endl;
            } else {
                kout[Fault] << "path fail " << sigleName << " is not't a director" << endl;
            }
        }
    }
    // if (tb->table.type & 0x10)
    // {
    //     kout[red] << "error path:path is a dir " << path << endl;
    //     return nullptr;
    // }
    if (tb) {
        tb->fat = this;
    }
    delete[] sigleName;
    // kout[blue]<<cpath<<endl;
    return tb;
}
 */
bool FAT32::show_empty_clus(Uint64 clus)
{

    unsigned char* buf = new unsigned char[Dbr.clus_size];

    Uint64 rclus = clus;

    FATtable* ft = (FATtable*)buf;
    while (rclus < 0xffffff8) {
        kout << "\trclus" << rclus << ":";
        get_clus(rclus, buf);
        for (int i = 0; i < Dbr.clus_size / 32; i++) {
            if (ft[i].attribute == 0 || ft[i].attribute == 0xe5) {
                kout << Blue << i << ' ';
            }
        }
        rclus = get_next_clus(rclus);
    }
    kout << endl;
}

Uint8 FAT32::TypeConvert(FileType type)
{
    Uint8 re = 0;
    if (type & FileType::__DEVICE) {
        re |= FATtable::device;
    }

    if (type & FileType::__DIR) {
        re |= FATtable::subdirenctory;
    }

    if (type == 0) {
        re |= FATtable::file;
    }
    return re;
}

FAT32FILE* FAT32::create_file(FileNode* dir_,const char* fileName, FileType type)
{
    FATtable temp;
    FAT32FILE* dir = (FAT32FILE*)dir_;
    memset((unsigned char*)&temp, 0, 32);
    if (dir == nullptr) {
        kout[Fault] << "dir isn't a nullptr" << endl;
        return nullptr;
    } else if (!(dir->TYPE & 0x1)) {
        kout[Fault] << dir->name << "is not a director" << endl;
        return nullptr;
    }

    Uint32 len = strlen(fileName);
    Uint64 tclus;
    unsigned char* buf = new unsigned char[Dbr.clus_size];
    Uint64 rclus = dir->clus;
    get_clus(rclus, buf);

    FATtable* ft = (FATtable*)buf;

    int n = (len / 13) + ((len % 13) ? 1 : 0);
    kout << "clus num" << n << endl;
    int re;
    // 创建目录项不会跨簇创建
    while (rclus < 0xffffff8) {
        kout << Red << rclus << endl;
        for (int i = 0; i < Dbr.clus_size / 32; i++) {
            int k = 0;
            while (ft[i].attribute == 0 || ft[i].attribute == 0xe5) {
                // kout << Yellow << i << endl;

                k++;
                if (i >= Dbr.clus_size / 32)
                    break;
                if (k == n + 1) {

                    toshortname(fileName, (char*)&temp);
                    // 设置时间
                    temp.high_clus = 0;
                    temp.low_clus = 0;
                    temp.type = TypeConvert(type);
                    re = i;
                    ft[i] = temp;
                    kout << "SSSS " << i << '\t';
                    i--;
                    char* p =new char[50];
                    strcpy(p,fileName) ;

                    for (int j = 0; j < n; j++) {
                        memset(&temp, 0, 32);
                        temp.type = 0x0f;
                        temp.attribute &= 0xf0;
                        if (j == n - 1) {
                            temp.attribute |= 0x40;
                        }

                        temp.attribute |= (j + 1 & 0xf);
                        p = unicodecopy((char*)temp.lname0, p, 5);
                        p = unicodecopy((char*)temp.lname1, p, 6);
                        p = unicodecopy((char*)temp.lname2, p, 2);
                        ft[i] = temp;
                        kout << "SSSS " << i << '\t';
                        i--;
                        // kout.memory(&temp, 32);
                    }
                    set_clus(rclus, buf);
                    delete[] buf;
                    FAT32FILE* rfile = new FAT32FILE(ft[re], fileName, this, rclus, re);
                    rfile->TYPE = 0;

                    unsigned char* clus = new unsigned char[512];
                    Uint64 test_clus = 2;
                    while (test_clus < 0xffffff8) {
                        kout << Blue << test_clus << endl;
                        test_clus = get_next_clus(test_clus);
                    }

                    return rfile;
                }
                i++;
            }
        }

        tclus = rclus;
        rclus = get_next_clus(rclus);

        if (rclus < 0xffffff8)
            get_clus(rclus, buf);
        else {
            kout << "Create clus" << endl;
            rclus = find_empty_clus();
            set_next_clus(tclus, rclus);
            set_next_clus(rclus, 0xffffff8);
            get_clus(rclus, buf);
        }
    }

    delete[] buf;
    return nullptr;
}

FAT32FILE* FAT32::create_dir(FileNode* dir_,const char* fileName)
{
    FAT32FILE* dir = (FAT32FILE*)dir_;
    FAT32FILE* re;
    re = create_file(dir, fileName, FileType::__DIR);
    Uint64 rclus = find_empty_clus();

    re->clus = rclus;
    set_table(re); // 更新目录项

    // 设置.文件
    Uint8* clus = new Uint8[Dbr.clus_size];
    get_clus(re->clus, clus);
    FATtable* ft;
    ft = (FATtable*)clus;
    FATtable temp;

    temp = re->table;
    strcpy_no_end(temp.name, ".          ");
    ft[0] = temp;

    temp = re->table;
    strcpy_no_end(temp.name, "..         ");
    temp.low_clus = re->table_clus_pos & 0xffff;
    temp.high_clus = (re->table_clus_pos >> 16) & 0xffff;
    ft[1] = temp;

    set_clus(re->clus, clus);

    delete[] clus;
    return re;
}


FAT32FILE* FAT32::open(const char* path, FileNode* _parent)
{
    // kout[Info] << "FAT32::open " << path << " " << _parent << endl;
    char* sigleName = new char[50];
    unsigned char* clus = new unsigned char[Dbr.clus_size];
    Uint64 clus_n = Dbr.root_clus;
    FAT32FILE* tb = (FAT32FILE*)_parent;
    FAT32FILE* pre;

    FATtable* ft;
    
    while ((path = split_path_name(path, sigleName)) != nullptr) {
        // kout[green] << sigleName << endl;
        pre = tb;
        tb = get_child_form_clus(sigleName, clus_n);
        if (tb == nullptr) {
            // kout[red] << "can't find file:" << sigleName << endl;
            delete[] sigleName;
            return nullptr;
        }
        // if (sigleName[0]) {
        // kout[yellow] << tb->name << endl;
        // if (tb->table.type & 0x10) // 目录
        // {
        if (pre->child) {
            pre->child->pre = tb;
            tb->next = pre->child;
        }
        pre->child = tb;
        tb->parent = pre;
        tb->vfs = this;
        clus_n = tb->table.low_clus | (Uint64)tb->table.high_clus << 16;
        tb->RefCount++;
        tb->fileSize = tb->table.size;
        // } else {
        // kout[Fault] << "path fail " << sigleName << " is not't a director" << endl;
        //
        // }
    }
    // tb->show();
    delete[] sigleName;
    // kout[blue]<<cpath<<endl;
    return tb;
}

bool FAT32::close(FileNode* p)
{
    return 0;
}

Sint64 FAT32FILE::read(void* buf_, Uint64 size)
{

    kout << "FAT32FILE::read" << endl;
    // ASSERTEX(buf_, __FILE__ << __LINE__ << " buf is nullptr");
    unsigned char* buf = (unsigned char*)buf_;

    if (size == 0) {
        kout[Info] << "There is nothing" << endl;
        return 0;
    }
    if (size > table.size) {
        size = table.size;
    }
    FAT32* fat = (FAT32*)vfs;
    // ASSERTEX(fat, __FILE__ << __LINE__ << " fat is nullptr");

    int n = size / fat->Dbr.clus_size + ((size % fat->Dbr.clus_size) ? 1 : 0);
    // kout << n << endl;
    unsigned char* p = new unsigned char[fat->Dbr.sector_size];
    // ASSERTEX(p, __FILE__ << __LINE__ << " p is nullptr");

    Uint64 rclus = clus;
    for (int i = 0; i < n; i++) {
        if (rclus < 2 || rclus >= 0xffffff7)
            return -1;

        fat->get_clus(rclus, &buf[i * fat->Dbr.clus_size]);
        rclus = fat->get_next_clus(rclus);
    }
    buf[size] = 0;
    delete[] p;
    return size;
}

Sint64 FAT32FILE::read(void* buf_, Uint64 pos, Uint64 size)
{
    unsigned char* buf = (unsigned char*)buf_;
    kout << "FAT32FILE::read" << endl;
    if (size == 0 && pos + size > table.size) {
        kout[Info] << "There is nothing" << endl;
        return 0;
    }
    if (pos + size > table.size) {
        // kout[Fault]<<"error"<<endl;
        size = table.size - pos;
    }
    FAT32* fat = (FAT32*)vfs;
    // kout<<fat<<endl;
    // kout<<fat->Dbr<<endl;
    Uint64 start = pos / fat->Dbr.clus_size;
    Uint64 end = (pos + size) / fat->Dbr.clus_size + (((pos + size) % fat->Dbr.clus_size) ? 1 : 0);
    Uint64 rclus = clus;
    // kout << start << ' ' << end << endl;
    unsigned char* p = new unsigned char[(end - start) * fat->Dbr.clus_size];

    int k = 0;
    while (k < start) {
        if (rclus < 2 || rclus >= 0xffffff7)
            return -1;
        rclus = fat->get_next_clus(rclus);
        k++;
    }
    // kout << i << endl;
    for (int i = 0; i < end - start; i++) {
        if (rclus < 2 || rclus >= 0xffffff7)
            return -1;

        fat->get_clus(rclus, &p[i * fat->Dbr.clus_size]);
        // kout<<Green<<i * fat->Dbr.clus_size<<" "<<&p[i * fat->Dbr.clus_size]<<endl;
        // kout<<Green<<DataWithSizeUnited( &p[i * fat->Dbr.clus_size],fat->Dbr.clus_size,16);
        // kout.memory(&p[i * fat->Dbr.clus_size], fat->Dbr.clus_size);
        rclus = fat->get_next_clus(rclus);
    }

    pos %= fat->Dbr.clus_size;
    // kout<<Red<< &p[8 * fat->Dbr.clus_size]<<endl;
    // kout<<Red<<DataWithSizeUnited( &p[8 * fat->Dbr.clus_size],fat->Dbr.clus_size,16);
    // kout<<Red<<DataWithSizeUnited(p,0x1141,16);

    for (int i = 0; i < size; i++) {
        buf[i] = p[pos + i];
    }

    delete[] p;
    return size;
}

Uint64 FAT32::find_empty_clus()
{

    kout << Red << "Find empty clus  " ;
    Uint32* p = (Uint32*)new unsigned char[Dbr.sector_size];
    Uint64 re = 0xfffffff;

    for (int i = 0; i < Dbr.FAT_sector_num; i++) {
        Disk.readSector(FAT1lba + i, (Sector*)p);
        for (int j = 0; j < sectorSize / 4; j++) {
            if (p[j] == 0) {
                re = i * Dbr.sector_size / 4 + j;
                // kout[Info]<<re<<endl;
                clear_clus(re);
                set_next_clus(re, 0xffffff8);
                delete[] p;
                return re;
            }
        }
    }

    kout[Warning]<<"can't find empty clus"<<endl;
    delete[] p;
    return 0xfffffff;
}

bool FAT32::del(FileNode* file_)
{
    FAT32FILE* file = (FAT32FILE*)file_;
    kout << Red << "del_file  " << endl;
    FATtable* p = (FATtable*)new unsigned char[Dbr.clus_size];
    get_clus(file->table_clus_pos, (unsigned char*)p);

    if ((file->TYPE & FileType::__DIR) && !(file->TYPE & FileType::__SPECICAL)) {
        FAT32FILE* t;
        t = get_next_file(file);
        // t->show();
        while (t) {
            del(t);
            t = get_next_file(file, t, EXCEPTDOT);
        }
    }

    Uint64 k = file->table_clus_off;
    p[k].type1 = 0x0f;
    while (p[k].attribute != 0xe5 && p[k].type1 == 0x0f) {
        p[k].attribute = 0xe5;
        k--;
    }
    set_clus(file->table_clus_pos, (unsigned char*)p);

    Uint64 rclus = file->clus;
    Uint64 nxt;

    if (rclus >= 2) {
        while (rclus < 0xffffff7) {
            nxt = get_next_clus(rclus);
            set_next_clus(rclus, 0);
            rclus = nxt;
        }
    }

    set_next_clus(rclus, 0);

    delete[] p;
    return true;
}


void FAT32::show_all_file_in_dir(FAT32FILE * dir,Uint32 level)
{
    
    auto show_space=[](int i)
    {
        for(;i>=0;i--)
            kout<<'-';        
    };

    FAT32FILE * t=nullptr; 
    t=get_next_file(dir,t);
    while (t) {
        show_space(level);
        kout<<t->name<<endl;

        if ((t->TYPE &FileType::__DIR)&&!(t->TYPE&FileType::__SPECICAL)) {
            show_all_file_in_dir(t);
        }
        t=get_next_file(dir,t);
    }
}



Sint64 FAT32FILE::write(void* src_, Uint64 pos, Uint64 size)
{

    unsigned char* src = (unsigned char*)src_;

    kout << Red << "write  " << endl;
    if (table.type & 0x1) {
        kout[Fault] << "this is a director" << endl;
        return false;
    }

    FAT32* fat = (FAT32*)vfs;

    Uint64 start = pos / fat->Dbr.clus_size;
    // Uint64 end = (pos + size) / fat->Dbr.clus_size + (((pos + size) % fat->Dbr.clus_size) ? 1 : 0);
    Uint64 rclus;
    // kout << start << ' ' << end << endl;
    // unsigned char* p = new unsigned char[(end - start) * fat->Dbr.clus_size];

    // 使rclus指向下一个簇,clus指向一个有效的簇
    if (clus >= 2 && clus < 0xffffff8) {
        rclus = fat->get_next_clus(clus);
    } else {
        clus = fat->find_empty_clus();
        rclus = 0xffffff8;
    }

    // 定位到开头
    int k = 0;
    while (k < start) {
        if (clus < 2 || clus >= 0xffffff7)
            return -1;
        clus = fat->get_next_clus(clus);
        k++;
    }

    // kout[green] << clus << endl;

    Uint64 nxt;

    /*     while (rclus < 0xffffff8 && rclus >= 2) {
            nxt = fat->get_next_clus(rclus);
            fat->set_next_clus(rclus, 0);
            rclus = nxt;
        }
     */
    // fat->set_clus(clus, src);
    int first_size = ((size > fat->Dbr.clus_size) ? (fat->Dbr.clus_size-pos % (fat->Dbr.clus_size)) : size);
    fat->cover_clus(clus, src, pos % (fat->Dbr.clus_size), first_size);


    rclus = clus;

    if (size+(pos%fat->Dbr.clus_size) > fat->Dbr.clus_size) {
        size -= first_size;
        src=&src[first_size];

        for (int i = 0; i < size / fat->Dbr.clus_size + (size % fat->Dbr.clus_size ? 1 : 0); i++) {
            nxt = fat->get_next_clus(rclus);
            if (nxt < 2 || nxt >= 0xffffff7) {
                nxt = fat->find_empty_clus();
            }
            fat->set_next_clus(rclus, nxt);
            rclus = nxt;
            fat->set_clus(rclus, &src[fat->Dbr.clus_size * i]);
        }
    }
    fat->set_next_clus(rclus, 0xfffffff);

    table.size = ((table.size>(pos+size))?table.size:(pos+size));
    // 设置时间
    fat->set_table(this);

    return size;
}
Sint64 FAT32FILE::write(void* src_, Uint64 size)
{

    kout << Red << "write  " << endl;
    if (table.type & 0x1) {
        kout[Fault] << "this is a director" << endl;
        return false;
    }

    unsigned char* src = (unsigned char*)src_;
    FAT32* fat = (FAT32*)vfs;
    Uint64 rclus;

    if (clus >= 2 && clus < 0xffffff8) {
        rclus = fat->get_next_clus(clus);
    } else {
        clus = fat->find_empty_clus();
        rclus = 0xffffff8;
    }
    // kout[green] << clus << endl;

    Uint64 nxt;

    while (rclus < 0xffffff8 && rclus >= 2) {
        nxt = fat->get_next_clus(rclus);
        fat->set_next_clus(rclus, 0);
        rclus = nxt;
    }

    fat->set_clus(clus, src);

    rclus = clus;

    if (size > fat->Dbr.clus_size) {
        for (int i = 1; i < (size+fat->Dbr.clus_size-1) / fat->Dbr.clus_size ; i++) {
            nxt = fat->find_empty_clus();
            fat->set_next_clus(rclus, nxt);
            rclus = nxt;
            fat->set_clus(rclus, &src[fat->Dbr.clus_size * i]);
        }
    }
    fat->set_next_clus(rclus, 0xfffffff);

    rclus = clus;
    while (rclus>=2&&rclus<=0xffffff7) {
        kout[Info]<<"find rclus"<<rclus<<endl;
        rclus=fat->get_next_clus(rclus);
    } 


    table.size = size;
    // 设置时间
    fat->set_table(this);

    return size;
}

// Uint64 FAT32::clus_off_in_fat(Uint64 clus)
// {
//     return clus % (sector_size / 4);
// }
// Uint64 FAT32::clus_sector_in_fat(Uint64 clus)
// {
//     return clus / (sector_size / 4);
// }

void FAT32FILE::show()
{

    kout << "name " << name << endl
         << "TYPE " << TYPE << endl;
    kout << "SIZE " << table.size << endl
         << "CLUS " << clus << endl
         << "POS  " << table_clus_pos << endl
         << "OFF  " << table_clus_off << endl
         << "ref  " << RefCount << endl
         << endl;
    // <<"Creation Time"<<1980+(table.S_date[1]&0xfe)<<'/'
}

Uint32 FAT32::get_next_clus(Uint32 clus)
{

    // kout << Red << "get_next_clus   " << clus << endl;
    Uint32* temp = new Uint32[Dbr.clus_size / 4];
    // Uint32 * temp = (Uint32 *)cache;
    // Uint32 * temp = (Uint32 *)pmm.alloc_pages(1);
    //
    // kout<<LightYellow<<temp<<endl;
    Disk.readSector(FAT1lba + clus * 4 / sectorSize, (Sector*)temp);

    Uint32 t = temp[clus % (sectorSize / 4)];
    delete[] temp;
    // pmm.free(temp);
    return t;
}

bool FAT32::set_next_clus(Uint32 clus, Uint32 nxt_clus) // 并不自动设置最后的值
{

    // kout << Red << clus << " SET NEXT CLUS " << nxt_clus << endl;
    unsigned char* temp = new unsigned char[Dbr.clus_size];
    if (clus > Dbr.FAT_sector_num * Dbr.sector_size / 4) {
        kout[Info] << "BIG then FAT1" << endl;
        return false;
    }

    Disk.readSector(FAT1lba + clus * 4 / sectorSize, (Sector*)temp);
    Uint32* t = (Uint32*)temp;
    t[clus % (sectorSize / 4)] = nxt_clus;
    Disk.writeSector(FAT1lba + clus * 4 / sectorSize, (Sector*)temp);

    // Disk.readSector(FAT1lba + nxt_clus * 4 / sectorSize, (Sector*)temp);
    // t = (Uint32*)temp;
    // t[nxt_clus % (sectorSize / 4)] = 0xfffffff;
    // Disk.writeSector(FAT1lba + nxt_clus * 4 / sectorSize, (Sector*)temp);

    delete[] temp;

    return true;
}

bool FAT32::clear_clus(Uint64 clus)
{
    kout << Red << " CLEAR  CLUS " << clus << endl;

    unsigned char* buf = new unsigned char[Dbr.clus_sector_num * Dbr.sector_size];
    memset(buf, 0, Dbr.clus_sector_num * Dbr.sector_size);
    Uint64 lba = clus_to_lba(clus);
    Disk.writeSector(lba, (Sector*)buf, Dbr.clus_sector_num);

    delete[] buf;
    return true;
}

bool FAT32::set_clus(Uint64 clus, unsigned char* buf)
{
    kout << Red << " SET  CLUS " << clus << endl;
    Uint64 lba = clus_to_lba(clus);
    // for (int i = 0; i < Dbr.clus_sector_num; i++)
    // {
    //     Disk.writeSector(lba + i, (Sector *)&buf[sector_size * i]);
    // }
    Disk.writeSector(lba, (Sector*)buf, Dbr.clus_sector_num);

    return true;
}

bool FAT32::cover_clus(Uint64 clus, unsigned char* buf, Uint64 off, Uint64 size) // 不清除clus中的内容，而是覆盖;
{

    kout << Red << " COVER  CLUS " << clus << endl;

    Uint64 lba = clus_to_lba(clus);
    unsigned char* buf_ = new unsigned char[Dbr.clus_size];
    get_clus(clus, buf_);
    memcpy(&buf_[off], (const char*)buf, size);
    // for (int i = 0; i < Dbr.clus_sector_num; i++)
    // {
    //     Disk.writeSector(lba + i, (Sector *)&buf[sector_size * i]);
    // }
    Disk.writeSector(lba, (Sector*)buf_, Dbr.clus_sector_num);

    delete[] buf_;
    return true;
}

FAT32::~FAT32()
{
    unsigned char* temp = new Uint8[Dbr.clus_size];
    if (Dbr.FAT_num > 1) {
        for (int i = 0; i < Dbr.FAT_sector_num; i++) // 备份fat
        {
            Disk.readSector(FAT1lba + i, (Sector*)temp);
            Disk.writeSector(FAT2lba + i, (Sector*)temp);
        }
    }

    delete[] temp;
}

FAT32FILE* FAT32::get_next_file(FAT32FILE* dir, FAT32FILE* cur, bool (*p)(FATtable* temp))
{
    // kout[Info] << "FAT32::get_next_file" << endl;

    ASSERTEX(dir->RefCount, "dir is close");

    // if (cur) {
    // cur->show();
    // }
    // kout[Info]<<Dbr.clus_size<<endl;

    ASSERTEX(dir != nullptr, "dir is nullptr");
    if (!(dir->TYPE & FileType::__DIR)) {
        kout[Fault] << dir->name << "isn't a dir" << endl;
        return nullptr;
    }
    // kout[Info] << __FILE__ << __LINE__ << endl;

    // kout[Info]<<Dbr.clus_size<<endl;
    unsigned char* clus = new unsigned char[Dbr.clus_size];

    Uint64 src_clus;
    // kout[Info] << __FILE__ << __LINE__ << endl;
    if (cur)
        src_clus = cur->table_clus_pos;
    else
        src_clus = dir->clus;
    // kout[Info] << __FILE__ << __LINE__ << endl;
    get_clus(src_clus, clus);

    // kout << DataWithSize(clus, 512) << endl;

    // kout[Info] << __FILE__ << __LINE__ << endl;
    FATtable* ft = (FATtable*)clus;
    FAT32FILE* re = nullptr;
    Sint32 t;
    Sint32 k;
    char* sName = new char[30];
    sName[26] = 0;
    sName[27] = 0;
    char* lName = new char[100];
    Uint64 pos; //= cur ? (cur->table_clus_off + 1 ): 0; // 当没传入cur时从文件初开始遍历；
    if (cur) {
        pos = cur->table_clus_off + 1;
    } else {
        pos = 0;
    }

    // kout[Info] << src_clus << " " << pos << endl;
    Uint64 test_clus = 2;
    while (test_clus < 0xffffff8) {
        // kout << Green << test_clus << endl;
        test_clus = get_next_clus(test_clus);
    }

    while (src_clus < 0xffffff8) {
        for (int i = pos; i < Dbr.clus_size / 32; i++) {
            while ((t = ft[i].get_name(sName)) > 0) {
                unicode_to_ascii(sName);

                // kout<<sName<<endl;
                if (t & 0x40) {
                    // kout[red]<<"yes"<<endl;
                    strcpy(&lName[((t & 0xf) - 1) * 13], sName);
                } else
                    strcpy_no_end(&lName[((t & 0xf) - 1) * 13], sName);
                i++;
            }
            if (t == -1)
                continue;
            if (t == -2) { // 说明文件夹开头是'.'
                ASSERTEX(lName, "lName is nullptr");
                if (ft[i].name[1] == '.')
                    strcpy(lName, "..");
                else
                    strcpy(lName, ".");
            }

            // if (strcmp("mnt",lName)==0)
            // kout[red]<<"find!!!";
            //     strcpy(lName, sName);

            if (p(&ft[i])) {
                // kout << Green << lName << endl;
                re = new FAT32FILE(ft[i], lName, this, src_clus, i);
                // kout<<lName<<' '<<Hex(clus_to_lba(src_clus)*512);
                // if (dir==vfsm.get_root()) kout[Fault]<<"error"<<endl;

                re->parent = dir;
                if (dir->child) {
                    dir->child->pre = re;
                }
                re->next = dir->child;
                dir->child = re;

                // kout<<vfsm.get_root()->child<<endl;
                // kout[Error] << __FILE__ << __LINE__ << endl;
                if (t == -2) {
                    re->TYPE |= FileType::__SPECICAL;
                    kout[Info] << "find special file" << endl;
                }
                // kout << re << endl;
                delete[] sName;
                delete[] clus;
                delete[] lName;
                // kout[Error] << __FILE__ << __LINE__ << endl;
                // kout[Error] << re->name<<endl;

                vfsm.open(re);
                return re;
            }
        }
        pos = 0;
        src_clus = get_next_clus(src_clus);
        if (src_clus < 0xffffff8)
            get_clus(src_clus, clus);
    }

    // kout<<Blue<<"dir_fat 7"<<dir->fat<<endl;
    delete[] sName;
    delete[] clus;
    delete[] lName;
    return re;
}

bool FAT32::set_table(FAT32FILE* file)
{

    kout << Red << " SET  table " << endl;

    Uint8* temp = new Uint8[Dbr.clus_size];
    FATtable* ft;
    get_clus(file->table_clus_pos, temp);

    file->table.high_clus |= (file->clus >> 16) & 0xff;
    file->table.low_clus |= file->clus & 0xff;

    ft = (FATtable*)temp;
    memcpy(&ft[file->table_clus_off], (char*)&(file->table), 32);
    set_clus(file->table_clus_pos, temp);
    delete[] temp;

    return true;
}

bool ALLTURE(FATtable* t)
{
    return true;
}

bool VALID(FATtable* t)
{
    return t->attribute != 0xe5;
}

bool EXCEPTDOT(FATtable* t)
{
    return t->attribute != 0x2e;
}
