#include "Driver/VirtioDisk.hpp"
#include "File/lwext4_include/ext4.h"
#include "File/vfsm.hpp"
#include "Library/KoutSingle.hpp"
#include "Library/Pathtool.hpp"
#include "Synchronize/Synchronize.hpp"
#include "Types.hpp"
#include <File/myext4.hpp>

Sint64 ext4node::read(void* buf_, Uint64 pos, Uint64 size)
{
    unsigned char* buf = (unsigned char*)buf_;

    if (TYPE == __DIR) {
        kout[EXT] << "file is dir" << endl;
        return false;
    }
    // kout[Debug] << "ext4::read1" << endl;

    // kout[EXT] << "ext4::read" << endl;
    if (size == 0 && pos + size > fp.fsize) {
        kout[Warning] << "There is nothing" << endl;
        return 0;
    }
    // kout[Debug] << "ext5::read1" << endl;
    if (pos >= fp.fsize) {
        kout[Warning] << "pos bigger then file size" << endl;
        return -1;
    }
    if (pos + size > fp.fsize) {
        // kout[Fault]<<"error"<<endl;
        size = fp.fsize - pos;
    }
    // kout[EXT] << "ext4::read pos"<<pos<<" size "<<size  << endl;

    // kout[Debug] << "ext6::read1" << endl;
    char* path = new char[255];
    vfs->get_file_path(this, path);
    path[strlen(path) - 1] = 0;

    ext4_fopen(&fp, path, "r");

    ext4_fseek(&fp, pos, SEEK_SET);
    size_t* rcnt = new size_t;
    int r = ext4_fread(&fp, buf, size, rcnt);
    // kout[EXT]<<"read in buf:" << (void*)buf<<" size "<<(void *)size<<" pos " <<(void *)pos<<" rcnt "<<(void *)*rcnt << endl;
    // kout<<Red<<DataWithSizeUnited(buf,0x100,32);
    if (*rcnt != size) {
        kout[Warning] << "read count isn't size" << endl;
    }

    r = *rcnt;
    delete rcnt;
    delete[] path;
    // kout[Debug] << "ext4::read1 return size " << r << endl;
    return r;
}

Sint64 ext4node::read(void* buf_, Uint64 size)
{
    unsigned char* buf = (unsigned char*)buf_;

    if (TYPE == __DIR) {
        return false;
    }

    kout[EXT] << "ext4::read" << endl;
    if (size == 0 && size > fp.fsize) {
        kout[EXT] << "There is nothing" << endl;
        return 0;
    }

    if (size > fp.fsize) {
        // kout[Fault]<<"error"<<endl;
        size = fp.fsize;
    }
    char* path = new char[255];
    vfs->get_file_path(this, path);
    path[strlen(path) - 1] = 0;

    ext4_fopen(&fp, path, "rb");

    ext4_fseek(&fp, 0, SEEK_SET);

    size_t* rcnt = new size_t;
    int r = ext4_fread(&fp, buf, size, rcnt);

    size = *rcnt;
    delete rcnt;
    delete[] path;
    return size;
}

Sint64 ext4node::write(void* src_, Uint64 pos, Uint64 size)
{
    unsigned char* src = (unsigned char*)src_;

    if (TYPE == __DIR) {
        return false;
    }

    char* path = new char[255];
    vfs->get_file_path(this, path);
    path[strlen(path) - 1] = 0;

    // ext4_fopen(&fp, path, "wb+");
    kout[EXT] << this->fp.fsize << "    address:   " << &fp.fsize << endl;

    int r = ext4_fseek(&fp, pos, SEEK_SET);
    if (r != EOK) {
        kout[EXT] << "seek fail" << endl;
        return -1;
    }

    size_t* rcnt = new size_t;
    r = ext4_fwrite(&fp, src, size, rcnt);

    delete rcnt;
    delete[] path;
    return size;
}

Sint64 ext4node::write(void* src_, Uint64 size)
{
    unsigned char* src = (unsigned char*)src_;

    if (TYPE == __DIR) {
        return false;
    }
    char* path = new char[200];
    vfs->get_file_path(this, path);
    path[strlen(path) - 1] = 0;

    ext4_fopen(&fp, path, "wb");

    int r = ext4_fseek(&fp, 0, SEEK_SET);
    if (r != EOK) {
        kout << "seek fail" << endl;
        return -1;
    }

    size_t* rcnt = new size_t;
    r = ext4_fwrite(&fp, src, size, rcnt);

    delete[] path;
    delete rcnt;
    return size;
}

bool ext4node::set_name(char* _name)
{
    char* path = new char[200];
    vfs->get_file_path(this, path);
    path[strlen(path) - 1] = 0;
    kout[EXT] << "old name is :" << path << endl;

    if (name) {
        delete[] name;
    }

    name = new char[strlen(_name) + 5];
    strcpy(name, _name);

    char* path1 = new char[200];
    vfs->get_file_path(this, path1);
    path1[strlen(path1) - 1] = 0;
    kout[EXT] << "new name is :" << path1 << endl;

    if (TYPE == __FILE || TYPE == __LINK) {
        ext4_frename(path, path1);
    } else if (TYPE == __DIR) {
        ext4_dir_mv(path, path1);
    }
    delete[] path;
    delete[] path1;
    delete[] name;
    return true;
}

void ext4node::initlink(ext4_file tb, const char* Name, EXT4* fat_)
{
    TYPE = __LINK;
    fp = tb;
    ASSERTEX(name==nullptr, "name isn't nullptr "<<(void *)name);
    name = new char[strlen(Name) + 1];
    strcpy(name, Name);

    vfs = fat_;
    fileSize = tb.fsize;
}

void ext4node::initfile(ext4_file tb, const char* Name, EXT4* fat_)
{
    TYPE = __FILE;
    fp = tb;

    ASSERTEX(name==nullptr, "name isn't nullptr "<<(void *)name);
    name = new char[strlen(Name) + 1];
    strcpy(name, Name);

    vfs = fat_;

    fileSize = tb.fsize;
    // ASSERTEX(fileSize==0, "file_size is 0"<<name);
}

void ext4node::initdir(ext4_dir tb, const char* Name, EXT4* fat_)
{
    TYPE = __DIR;
    fd = tb;
    ASSERTEX(name==nullptr, "name isn't nullptr "<<(void *)name);

    name = new char[strlen(Name) + 1];
    strcpy(name, Name);

    vfs = fat_;
}

void ext4node::show()
{
    kout[Info] << "name " << name << endline
               << "TYPE " << TYPE << endl;
    kout[Info] << "ref  " << RefCount << endl;
}

ext4node* EXT4::open(const char* _path, FileNode* _parent)
{
    char* path2 = new char[200];
    strcpy(path2, _path);

    // kout[DeBug] << "EXT4::open " << _path << " " << _parent << endl;
    char* sigleName = new char[50];

    // 获取全部完整路径
    char* path1 = new char[255];
    get_file_path(_parent, path1);
    char* path = new char[255];

    unified_path(path2, path1, path);
    // kout<<"jue dui lu jing:"<<path<<endl;
    delete[] path2;
    delete[] path1;

    path[strlen(path) - 1] = 0;
    if (ext4_inode_exist(path, 2) != EOK && ext4_inode_exist(path, 1) != EOK && ext4_inode_exist(path, 7) != EOK) {
        kout[EXT] << "file type unknown: " << path << endl;
        delete[] path;
        delete[] sigleName;
        return nullptr;
    }
    // kout[EXT]<<"open:"<<_parent<<endl;
    ext4node* tb = (ext4node*)_parent;
    ext4node* pre1;

    int allslash = count_slashes(path);
    kout[EXT] << "allslash is:" << allslash << endl;

    for (int i = 2; i <= allslash; i++) {
        pre1 = tb;

        char* temp_path = get_k_path(i, path);
        // kout[Debug] << i << " level dir is:" << temp_path << endl;
        ext4_dir temp;
        ext4_dir_open(&temp, temp_path);

        ext4node* now = new ext4node;
        char* name = get_k_to_k1_path(i - 1, path);
        // kout[Debug] << i << " level dir name is:" << name << endl;
        now->initdir(temp, name, this);
        ext4_dir_close(&temp);
        tb = now;

        if (tb == nullptr) {
            delete[] name;
            delete[] path;
            delete[] temp_path;
            delete[] sigleName;
            return nullptr;
        }

        if (pre1->child) {
            pre1->child->pre = tb;
            tb->next = pre1->child;
        }
        pre1->child = tb;
        tb->parent = pre1;
        tb->vfs = this;
        tb->RefCount++;

        delete[] temp_path;
        // delete now;
        delete[] name;
    }
    
    // kout[Debug]<<"AAA"<<endl;

    pre1 = tb;

    ext4_file temp;
    ext4_dir temp1;
    // path[strlen(path)-1]=0;

    char* name = get_last_path_segment(path);
    kout[EXT] << "last file name is:" << name << endl;
    ext4node* now = new ext4node;
    if (ext4_inode_exist(path, 2) == EOK) {
        ext4_dir_open(&temp1, path);
        now->initdir(temp1, name, this);
        tb = now;
    } else if (ext4_inode_exist(path, 1) == EOK) {
        ext4_fopen(&temp, path, "rb");

        now->initfile(temp, name, this);
        tb = now;
    } else if (ext4_inode_exist(path, 7) == EOK) {
        ext4_fopen(&temp, path, "rb");
        now->initlink(temp, name, this);
        tb = now;
    }

    if (tb == nullptr) {
        kout[EXT] << "tb is nullptr" << endl;
        delete now;
        delete [] name;
        delete [] path;
        delete[] sigleName;
        return nullptr;
    }

    if (pre1->child != nullptr) {
        pre1->child->pre = tb;
        tb->next = pre1->child;
    }
    pre1->child = tb;
    tb->parent = pre1;
    tb->vfs = this;
    tb->RefCount++;

    delete [] path;
    delete[] sigleName;
    delete[] name;
    // char ch[100];
    // tb->read(ch,100);
    return tb;
}

void EXT4::get_next_file(ext4node* dir, ext4node* cur, ext4node* tag)
{
    ASSERTEX(dir->RefCount, "dir is close");
    ASSERTEX(dir != nullptr, "dir is nullptr");

    if (!(dir->TYPE & FileType::__DIR)) {
        kout[Fault] << dir->name << "isn't a dir" << endl;
        return;
    }
    
    char* path = new char[255];

    get_file_path(dir, path);

    // kout[Info] << "path:" << path << endl;

    char sss[255];
    const ext4_direntry* de;
    ext4_dir d;
    int tar = 0;

    // kout[Info] << "get_next_file 1" << endl;
    int r = ext4_dir_open(&d, path);
    // kout[Info] << "get_next_file 1" << endl;
    if (r == ENOENT) {
        kout[EXT] << "open " << path << "failed" << endl;
        return;
    }
    if (cur != nullptr) {
        d.next_off = cur->offset;
    } else {
        d.next_off = 0;
    }

    // kout[EXT]<<"next file name:"<<(char*)de->name<<endl;
    do {
        de = ext4_dir_entry_next(&d);
        if (de == nullptr) {
            // kout[EXT] << "dao tou le" << endl;
            tag->offset = -1;
            // tag=nullptr;
            delete[] path;
            return;
        }
        memcpy(sss, (char*)de->name, de->name_length);
        sss[de->name_length] = 0;
        // kout[EXT] << "next file name:" <<sss << endl;
    } while (strcmp(sss, ".") == 0 || strcmp(sss, "..") == 0);

    strcat(path, sss);
    kout[EXT] << "whole path:" << path << endl;
    if (cur==tag) {
        cur->close();
    }

    if (de->inode_type == 2) {
        ASSERTEX(&tag->fd, "dir is nullptr");
        ext4_dir_open(&tag->fd, path);
        tag->initdir(tag->fd, sss, (EXT4*)dir->vfs);
    } else {
        r = ext4_fopen(&tag->fp, path, "r");

        // kout[DeBug] <<"TMEP Fsize "<<tag->fp.fsize<<endl;
        tag->initfile(tag->fp, sss, (EXT4*)dir->vfs);
    }

    tag->offset = d.next_off;
    tag->parent = dir;
    tag->RefCount++;
    delete[] path;
    return;
}

void EXT4::show_all_file_in_dir(ext4node* dir, Uint32 level)
{
    auto show_space = [](int i) {
        for (; i >= 0; i--)
            kout[EXT] << '-';
    };

    ext4node* t = nullptr;
    ext4node* tag = new ext4node;
    // kout<<"efg"<<endl;
    get_next_file(dir, t, tag);
    // kout<<"abcd"<<endl;
    if (tag->offset == -1) {
        delete tag;
        return;
    }
    tag->show();
    t = tag;
    t->parent = dir;
    while (t->offset != -1) {
        show_space(level);
        kout << t->name << endl;

        if ((t->TYPE & FileType::__DIR) && !(t->TYPE & FileType::__SPECICAL)) {
            show_all_file_in_dir(t);
        }
        get_next_file(dir, t, tag);
        t = tag;
        t->parent = dir;
    }
    delete tag;
}

ext4node* EXT4::create_dir(FileNode* dir_, const char* fileName)
{
    char* path = new char[255];
    get_file_path(dir_, path);
    strcat(path, fileName);
    kout[EXT] << "New dir Name is:" << path << endl;

    ext4_dir_mk(path);

    ext4_dir temp;
    ext4_dir_open(&temp, path);

    ext4node* p = new ext4node;
    p->initdir(temp, fileName, this);

    /*     ext4node* dir = (ext4node*)dir_;
        ext4node* c = (ext4node*)dir->child;
        ext4node* cc = new ext4node;

        if (c == nullptr) {
            dir->child = p;
            p->parent = dir;
            p->pre = p->next = nullptr;
            p->child = nullptr;
            delete[] path;
            delete cc;
            return p;
        }
        while (c != nullptr) {
            cc = c;
            c = (ext4node*)c->next;
        }
        cc->next = p;
        p->next = nullptr;
        p->pre = cc;
        p->child = nullptr;
        p->parent = dir;
     */
    delete[] path;
    // delete cc;
    return p;
}

ext4node* EXT4::create_file(FileNode* dir_, const char* fileName, FileType type)
{
    char* cwd = new char[255];
    char* path = new char[255];
    get_file_path(dir_, cwd);
    // strcat(path, fileName);

    unified_path(fileName, cwd, path);
    delete[] cwd;
    path[strlen(path) - 1] = '\0';

    ext4_file temp;
    int r = ext4_fopen(&temp, path, "wb");
    if (r != EOK) {
        kout[EXT] << "fopen is failed,r:" << r << endl;
        return nullptr;
    }
    // r = ext4_fwrite(&temp, "Hello World !\n", strlen("Hello World !\n"), 0);
    kout[EXT] << "fopen is sucess:" << endl;
    // r = ext4_fwrite(&temp, "Hello World !\n", strlen("Hello World !\n"), 0);

    ext4node* p = new ext4node;
    
    kout[DeBug] <<"TMEP Fsize "<<temp<<endl;
    p->initfile(temp, fileName, this);
    ext4_fclose(&temp);
    /*
        ext4node* dir = (ext4node*)dir_;
        ext4node* c = (ext4node*)dir->child;
        ext4node* cc = new ext4node;
        if (c == nullptr) {
            dir->child = p;
            p->parent = dir;
            p->pre = p->next = nullptr;
            p->child = nullptr;
            delete[] path;
            delete cc;
            return p;
        }

        while (c != nullptr) {
            cc = c;
            c = (ext4node*)c->next;
        }
        cc->next = p;
        p->next = nullptr;
        p->pre = cc;
        p->child = nullptr;
        p->parent = dir; */
    delete[] path;
    // delete cc;
    return p;
}

bool EXT4::del(FileNode* file)
{
    kout[EXT] << Red << "del_file  :" << file->name << endl;

    if ((file->TYPE & FileType::__DIR) && !(file->TYPE & FileType::__SPECICAL)) {
        ext4node* t = new ext4node;
        get_next_file((ext4node*)file, nullptr, t);
        // t->show();
        while (t) {
            del(t);
            get_next_file((ext4node*)file, t, t);
        }
    }

    char* path = new char[200];
    get_file_path((ext4node*)file, path);
    path[strlen(path) - 1] = 0;

    ext4_fremove(path);

    ext4_dir_rm(path);

    file->~FileNode();
     

    delete[] path;
}