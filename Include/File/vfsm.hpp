#ifndef __VFSM_HPP__
#define __VFSM_HPP__

#include "Memory/pmm.hpp"
#include "Memory/vmm.hpp"
#include "Types.hpp"
#include <File/FAT32.hpp>
#include <Library/Kstring.hpp>

class VFSM
{
private:
    FAT32FILE* OpenedFile;

    FAT32FILE* find_file_by_path(char* path, bool& isOpened);

public:
    FAT32FILE* open(const char* path, char* cwd);
    FAT32FILE* open(FAT32FILE* file);
    void close(FAT32FILE* t);

    void showRootDirFile();
    bool create_file(const char* path, char* cwd, char* fileName, Uint8 type = FATtable::FILE);
    bool create_dir(const char* path, char* cwd, char* dirName);
    bool del_file(const char* path, char* cwd);
    bool link(const char* srcpath, const char* ref_path, char* cwd);//ref_path为被指向的文件
    bool unlink(const char* path, char* cwd);
    bool unlink(char* abs_path);
    FAT32FILE* get_next_file(FAT32FILE* dir, FAT32FILE* cur = nullptr, bool (*p)(FATtable* temp) = VALID); // 获取到的dir下cur的下一个满足p条件的文件，如果没有则返回空

    char* unified_path(const char* path, char* cwd);
    void show_opened_file();
    bool init();
    bool destory();
    FAT32FILE* get_root();
};

extern VFSM vfsm;
class MemapFileRegion:public VirtualMemoryRegion
{
	protected:
		FAT32FILE *File=nullptr;
		Uint64 StartAddr=0,
			   Length=0,
			   Offset=0;
		
	public:
		ErrorType Save()//Save memory to file
		{
			VirtualMemorySpace *old=VirtualMemorySpace::Current();
			VMS->Enter();
			VMS->EnableAccessUser();
			Sint64 re=File->write((unsigned char *)StartAddr,Offset,Length);
			VMS->DisableAccessUser();
			old->Enter();
			return re>=0?ERR_None:-re;//??
		}
		
		ErrorType Load()//Load memory from file
		{
			VirtualMemorySpace *old=VirtualMemorySpace::Current();
			VMS->Enter();
			VMS->EnableAccessUser();
			Sint64 re=File->read((unsigned char*)StartAddr,Offset,Length);
			VMS->DisableAccessUser();
			old->Enter();
			return re>=0?ERR_None:-re;
		}
		
		ErrorType Resize(Uint64 len)
		{
			if (len==Length)
				return ERR_None;
			if (len>Length)
				if (nxt!=nullptr&&(StartAddr+len>nxt->GetStart()||StartAddr+len>0x70000000))
					return ERR_InvalidRangeOfVMR;
			Length=len;
			EndAddress=StartAddr+Length+PAGESIZE-1>>PageSizeBit<<PageSizeBit;
			//<<Free pages not in range...
			return ERR_None;
		}
		
		inline Uint64 GetStartAddr() const
		{return StartAddr;}
		
		~MemapFileRegion()//Virtual??
		{
			// File->Unref(nullptr);
			vfsm.close(File);
			if (VMS!=nullptr)
				VMS->RemoveVMR(this,0);
		}
		
		MemapFileRegion(FAT32FILE *node,void *start,Uint64 len,Uint64 offset,Uint32 prot)
		:VirtualMemoryRegion((PtrUint)start, (PtrUint)start+len, prot),File(node),StartAddr((PtrSint)start),Length(len),Offset(offset)
		{
			ASSERTEX(VirtualMemoryRegion::Init((PtrSint)start,(PtrSint)start+len,prot)==ERR_None,"MemapFileRegion "<<this<<" failed to init VMR!");
			// node->Ref(nullptr);
			vfsm.open(File);
		}
};

#endif