#ifndef  __PARSE_ELF__
#define  __PARSE_ELF__

#include <Types.hpp>

#define  EI_NIDENT 16

struct ELF_EHEADER
{
    union
    {
        Uint8 e_ident[EI_NIDENT];
        struct 
        {
            Uint8 ei_magic[4];
            Uint8 ei_class;
            Uint8 ei_data;
            Uint8 ei_version;
            Uint8 ei_pad[9];//扩展位
        };

    };
    Uint16 e_type;
    Uint16 e_machine;
    Uint32 e_version;
    Uint64 e_entry;
    Uint64 e_phoff;// 程序头表偏移量
    Uint64 e_shoff;//段表偏移
    Uint32 e_flags;
    Uint16 e_ehsize;//ELF文件头大小 
    Uint16 e_phentsize;//程序头表表项大小
    Uint16 e_phnum;//程序头表表项数目
    Uint16 e_shentsize;//
    Uint16 e_shnum;
    Uint16 e_shstrndx;
    inline bool is_ELF()
    {
        if (ei_magic[0]==0x7f&&ei_magic[1]=='E'&&ei_magic[2]=='L'&&ei_magic[3]=='F')
            return true;
        else 
            return false;
    };

}__attribute__((packed));  




struct ELF_PHEADER
{

}__attribute__((packed));



#endif