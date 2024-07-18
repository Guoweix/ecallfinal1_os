#include <File/myext4.hpp>
#include "Driver/VirtioDisk.hpp"
#include "File/vfsm.hpp"
#include "Library/KoutSingle.hpp"
#include "Synchronize/Synchronize.hpp"
#include "Types.hpp"
#include "Library/Pathtool.hpp"

Sint64 ext4node::read(void *buf_, Uint64 pos, Uint64 size)
{
    unsigned char *buf = (unsigned char *)buf_;

    if (TYPE == __DIR)
    {
        return false;
    }

    kout << "ext4::read" << endl;
    if (size == 0 && pos + size > fp.fsize)
    {
        kout[Info] << "There is nothing" << endl;
        return 0;
    }
    if (pos + size > fp.fsize)
    {
        // kout[Fault]<<"error"<<endl;
        size = fp.fsize - pos;
    }
    char *path;
    vfs->get_file_path(this, path);
    ext4_fopen(&fp, path, "rb");
    ext4_fseek(&fp, pos, SEEK_SET);

    size_t *rcnt;
    int r = ext4_fread(&fp, buf, size, rcnt);

    return size;
}

Sint64 ext4node::read(void *buf_, Uint64 size)
{
    unsigned char *buf = (unsigned char *)buf_;

    if (TYPE == __DIR)
    {
        return false;
    }

    kout << "ext4::read" << endl;
    if (size == 0 && size > fp.fsize)
    {
        kout[Info] << "There is nothing" << endl;
        return 0;
    }

    if (size > fp.fsize)
    {
        // kout[Fault]<<"error"<<endl;
        size = fp.fsize;
    }
    char *path;
    vfs->get_file_path(this, path);
    ext4_fopen(&fp, path, "rb");

    ext4_fseek(&fp, 0, SEEK_SET);

    size_t *rcnt;
    int r = ext4_fread(&fp, buf, size, rcnt);

    return size;
}

Sint64 ext4node::write(void *src_, Uint64 pos, Uint64 size)
{
    unsigned char *src = (unsigned char *)src_;

    if (TYPE == __DIR)
    {
        return false;
    }

    char *path;
    vfs->get_file_path(this, path);
    ext4_fopen(&fp, path, "wb");

    ext4_fseek(&fp, pos, SEEK_SET);

    size_t *rcnt;
    int r = ext4_fwrite(&fp, src, size, rcnt);

    return size;
}

Sint64 ext4node::write(void *src_, Uint64 size)
{
    unsigned char *src = (unsigned char *)src_;

    if (TYPE == __DIR)
    {
        return false;
    }
    char *path;
    vfs->get_file_path(this, path);
    ext4_fopen(&fp, path, "wb");

    ext4_fseek(&fp, 0, SEEK_SET);

    size_t *rcnt;
    int r = ext4_fwrite(&fp, src, size, rcnt);

    return size;
}

bool ext4node::set_name(char *_name)
{
    char *path;
    vfs->get_file_path(this, path);

    if (name)
    {
        delete[] name;
    }
    name = new char[strlen(_name) + 5];
    strcpy(name, _name);

    char *path1;
    vfs->get_file_path(this, path1);

    if (TYPE == __FILE)
    {
        ext4_frename(path, _name);
    }
    else if (flags == __DIR)
    {
        ext4_dir_mv(path, path1);
    }

    return true;
}

void ext4node::initfile(ext4_file tb, char *Name, EXT4 *fat_)
{
    TYPE = __FILE;
    fp = tb;
    name = new char[strlen(Name) + 1];
    strcpy(name, Name);

    vfs = fat_;
    fileSize = tb.fsize;
}

void ext4node::initdir(ext4_dir tb, char *Name, EXT4 *fat_)
{
    TYPE = __DIR;
    fd = tb;
    name = new char[strlen(Name) + 1];
    strcpy(name, Name);

    vfs = fat_;
}

void ext4node::show()
{
    kout << "name " << name << endl
         << "TYPE " << TYPE << endl;
    kout << "ref  " << RefCount << endl
         << endl;
}

ext4node *EXT4::open(char *path, FileNode *_parent)
{
    kout[Info] << "EXT4::open " << path << " " << _parent << endl;
    char *sigleName = new char[50];

    ext4node *tb = (ext4node *)_parent;
    ext4node *pre=new ext4node;

    int allslash = count_slashes(path);

    for (int i = 2; i <= allslash; i++)
    {
        pre = tb;

        char *temp_path = get_k_path(i, path);
        ext4_dir temp;
        ext4_dir_open(&temp, temp_path);

        ext4node *now;
        char *name = get_k_to_k1_path(i - 1, path);
        now->initdir(temp, name, this);
        tb = now;

        if (tb == nullptr)
        {
            delete pre;
            delete []sigleName;
            return nullptr;
        }

        if (pre->child)
        {
            pre->child->pre = tb;
            tb->next = pre->child;
        }
        pre->child = tb;
        tb->parent = pre;
        tb->vfs = this;
        tb->RefCount++;
    }
    ext4_file temp;
    ext4_dir temp1;
    int r = ext4_fopen(&temp, path, "rb");
    char *name = get_last_path_segment(path);
    ext4node *now;
    if (r != ENOENT)
    {
        now->initfile(temp, name, this);
        tb = now;
    }
    else
    {
        ext4_dir_open(&temp1, path);
        now->initdir(temp1, name, this);
        tb = now;
    }

    if (tb == nullptr)
    {
        delete pre;
        delete []sigleName;
        return nullptr;
    }

    if (pre->child)
    {
        pre->child->pre = tb;
        tb->next = pre->child;
    }
    pre->child = tb;
    tb->parent = pre;
    tb->vfs = this;
    tb->RefCount++;
    delete pre;
    delete []sigleName;

    return tb;
}

void EXT4::get_next_file(ext4node *dir, ext4node *cur, ext4node *tag)
{
    ASSERTEX(dir->RefCount, "dir is close");
    ASSERTEX(dir != nullptr, "dir is nullptr");

    if (!(dir->TYPE & FileType::__DIR))
    {
        kout[Fault] << dir->name << "isn't a dir" << endl;
        return;
    }

    char *path = new char[255];
    
        
        get_file_path(dir, path);
        
    
    kout << "path:" << path << endl;

    char sss[255];
    const ext4_direntry *de;
    ext4_dir d;
    int tar = 0;

    int r = ext4_dir_open(&d, path);
    if (r == ENOENT)
    {
        kout << "open " << path << "failed" << endl;
        return;
    }
    if (cur != nullptr)
    {
        d.next_off = cur->offset;
    }

    // kout<<"next file name:"<<(char*)de->name<<endl;
    do
    {
        de = ext4_dir_entry_next(&d);
        if (de == nullptr)
        {
            //kout << "dao tou le" << endl;
            tag->offset = -1;
            delete[] path;
            return;
        }
        memcpy(sss, (char *)de->name, de->name_length);
        kout << "next file name:" << (char *)de->name << endl;
        sss[de->name_length] = 0;
    } while (strcmp(sss, ".") == 0 || strcmp(sss, "..") == 0);

    strcat(path, sss);
    kout << "whole path:" << path << endl;
    ext4_file f;

    if(de->inode_type==2){
        ext4_dir d;
        ext4_dir_open(&d, path);
        tag->initdir(d, sss, nullptr);
    }else {
        r = ext4_fopen(&f, path, "r");
        tag->initfile(f, sss, nullptr);
    }
    
    kout << "create file/dir success" << endl;
    tag->offset = d.next_off;
    tag->RefCount++;
    delete[] path;
    return;
}

void EXT4::show_all_file_in_dir(ext4node *dir, Uint32 level)
{
    auto show_space = [](int i)
    {
        for (; i >= 0; i--)
            kout << '-';
    };

    ext4node *t = nullptr;
    ext4node *tag = new ext4node;
    //kout<<"efg"<<endl;
    get_next_file(dir, t, tag);
    //kout<<"abcd"<<endl;
    if (tag->offset == -1)
    {
        delete tag;
        return;
    }
    tag->show();
    t = tag;
    t->parent = dir;
    while (t->offset != -1)
    {
        show_space(level);
        kout << t->name << endl;

        if ((t->TYPE & FileType::__DIR) && !(t->TYPE & FileType::__SPECICAL))
        {
            show_all_file_in_dir(t);
        }
        get_next_file(dir, t, tag);
        t = tag;
        t->parent = dir;
    }
    delete tag;
}

ext4node *EXT4::create_dir(FileNode *dir_, char *fileName)
{
    char *path=new char[255];
    get_file_path(dir_, path);
    strcat(path,fileName);
    kout<<"New file Name is:"<<path<<endl;

    ext4_dir_mk(path);

    ext4_dir temp;
    ext4_dir_open(&temp, path);

    ext4node *p;
    p->initdir(temp, fileName, this);

    ext4node *dir = (ext4node *)dir_;
    ext4node *c = (ext4node *)dir->child;
    ext4node *cc;

    if(c==nullptr){
        dir->child=p;
        p->parent=dir;
        p->pre=p->next=nullptr;
        p->child=nullptr;
        delete []path;
        delete cc;
        return p;
    }
    while (c != nullptr)
    {
        cc = c;
        c = (ext4node *)c->next;
    }
    cc->next = p;
    p->next = nullptr;
    p->pre = cc;
    p->child = nullptr;
    p->parent = dir;
    delete []path;
    delete cc;
    return p;
}

ext4node *EXT4::create_file(FileNode *dir_, char *fileName, FileType type)
{
    char *path=new char[255];
    get_file_path(dir_, path);
    strcat(path,fileName);
    kout<<"New file Name is:"<<path<<endl;

    ext4_file temp;
    int r=ext4_fopen(&temp, path, "wb");
    if(r!=EOK){
        kout<<"fopen is failed,r:"<<r<<endl;
        return nullptr;
    }
    //r = ext4_fwrite(&temp, "Hello World !\n", strlen("Hello World !\n"), 0);
    kout<<"fopen is sucess:"<<endl;
    //r = ext4_fwrite(&temp, "Hello World !\n", strlen("Hello World !\n"), 0);
    ext4_fclose(&temp);
    
    ext4node *p=new ext4node;
    p->initfile(temp, fileName, this);

    ext4node *dir = (ext4node *)dir_;
    ext4node *c = (ext4node *)dir->child;
    ext4node *cc=new ext4node;
    if(c==nullptr){
        dir->child=p;
        p->parent=dir;
        p->pre=p->next=nullptr;
        p->child=nullptr;
        delete []path;
        delete cc;
        return p;
    }

    while (c != nullptr)
    {
        cc = c;
        c = (ext4node *)c->next;
    }
    cc->next = p;
    p->next = nullptr;
    p->pre = cc;
    p->child = nullptr;
    p->parent = dir;
    delete []path;
    delete cc;
    return p;
}

bool EXT4::del(FileNode *file)
{
    kout << Red << "del_file  " << endl;

    if ((file->TYPE & FileType::__DIR) && !(file->TYPE & FileType::__SPECICAL))
    {
        ext4node *t = new ext4node;
        get_next_file((ext4node *)file, nullptr, t);
        // t->show();
        while (t)
        {
            del(t);
            get_next_file((ext4node *)file, t, t);
        }
    }

    char *path;
    get_file_path((ext4node *)file, path);

    ext4_fremove(path);

    ext4_dir_rm(path);

    file->~FileNode();
}