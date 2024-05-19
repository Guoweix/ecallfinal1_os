#ifndef POS_FAT32_HPP
#define POS_FAT32_HPP

#include "FileSystem.hpp"
#include <Library/KoutSingle.hpp>
#include <Library/Kstring.hpp>
#include <Library/DataStructure/PAL_Tuple.hpp>
#include "../Driver/VirtioDisk.hpp"

const Uint64 SECTORSIZE = 512;
constexpr Uint64 ClusterEndFlag=0x0FFFFFFF;

inline bool IsClusterEnd(Uint64 cluster)
{return POS::InRange(cluster,0x0FFFFFF8,0x0FFFFFFF);}

class StorageDevice {
	
public:
	virtual ErrorType Init() = 0;
	virtual ErrorType Read(Uint64 lba, unsigned char* buffer) = 0; 
	virtual ErrorType Write(Uint64 lba, unsigned char* buffer) = 0;
};

class FAT32Device :public StorageDevice {
public:
	ErrorType Init(){
		return ERR_None;;
	}
	ErrorType Read(Uint64 lba, unsigned char* buffer){
		
	}
	ErrorType Write(Uint64 lba, unsigned char* buffer){
		
	}
};
class VirtualFileSystem;

struct DBR {
	Uint32 BPB_RsvdSectorNum; 
	Uint32 BPB_FATNum;
	Uint32 BPB_SectorPerFATArea; 
	Uint32 BPB_HidenSectorNum; 
	Uint64 BPBSectorPerClus;
};

class FAT32 :public VirtualFileSystem{
	friend class FAT32FileNode;
public:

	virtual FileNode* FindFile(const char* path, const char* name) override;
	virtual int GetAllFileIn(const char* path, char* result[], int bufferSize, int skipCnt = 0) override;//if unused,result should be empty when input , user should free the char*
	virtual int GetAllFileIn(const char* path, FileNode* nodes[], int bufferSize, int skipCnt = 0) override;
	virtual ErrorType CreateDirectory(const char* path) override;
	virtual ErrorType CreateFile(const char* path) override;
	virtual ErrorType Move(const char* src, const char* dst) override;
	virtual ErrorType Copy(const char* src, const char* dst) override;
	virtual ErrorType Delete(const char* path)override;
	virtual FileNode* GetNextFile(const char* base) override;

	virtual FileNode* Open(const char* path) override;
	virtual ErrorType Close(FileNode* p) override;

	Uint64 DBRLba;
	DBR Dbr;
	Uint64 FAT1Lba;
	Uint64 FAT2Lba;
	Uint64 RootLba;
	FAT32Device device;


	FAT32();
	FileNode* LoadShortFileInfoFromBuffer(unsigned char* buffer);
	ErrorType LoadLongFileNameFromBuffer(unsigned char* buffer,Uint32* name);
	char*  MergeLongNameAndToUtf8(Uint32* buffer[], Uint32 cnt);
	Uint64 GetLbaFromCluster(Uint64 cluster);
	Uint64 GetSectorOffsetFromlba(Uint64 lba);
	Uint32 GetFATContentFromCluster(Uint32 cluster);
	ErrorType SetFATContentFromCluster(Uint32 cluster,Uint32 content);
	ErrorType ReadRawData(Uint64 lba, Uint64 offset, Uint64 size, unsigned char* buffer);
	ErrorType WriteRawData(Uint64 lba, Uint64 offset, Uint64 size, unsigned char* buffer);
	FileNode* FindFileByNameFromCluster(Uint32 cluster, const char* name);
	FileNode* FindFileByPath(const char* path);
	bool IsExist(const char* path);
	bool IsShortContent(const char* name);
	PAL_DS::Doublet <unsigned char*,Uint8 > GetShortName(const char*);
	PAL_DS::Doublet <unsigned char*, Uint64> GetLongName(const char *);
	Uint32 GetFreeClusterAndPlusOne();
	ErrorType AddContentToCluster(Uint32 cluster,unsigned char * buffer,Uint64 size);
	PAL_DS::Doublet<Uint64,Uint64> GetContentLbaAndOffsetFromPath();
	PAL_DS::Triplet<Uint32, Uint64,Uint64>  GetFreeClusterAndLbaAndOffsetFromCluster(Uint32 cluster);
	unsigned char CheckSum(unsigned char* data);

public:
	ErrorType Init();
	const char* FileSystemName() override;
};


class FAT32FileNode :public FileNode {
	friend class FAT32;
public:

	Uint32 FirstCluster; 
	FAT32FileNode* nxt;
	bool IsDir; 
	Uint64 ReadSize;
	Uint64 ContentLba;
	Uint64 ContentOffset;

	virtual Sint64 Read(void* dst, Uint64 pos, Uint64 size) override;
	virtual Sint64 Write(void* src, Uint64 pos, Uint64 size) override;
	ErrorType SetSize(Uint32 size);
	PAL_DS::Doublet <Uint32, Uint64> GetCLusterAndLbaFromOffset(Uint64 offset);
	FAT32FileNode(FAT32* _vfs,Uint32 cluster,Uint64 _ContentLba,Uint64 _ContentOffset);
	~FAT32FileNode();
};

#endif
