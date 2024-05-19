#ifndef POS_FILESYSTEM_HPP
#define POS_FILESYSTEM_HPP

#include "../Error.hpp"
#include "../Library/KoutSingle.hpp"
#include "../Library/DataStructure/LinkTable.hpp"
#include "../Library/DataStructure/PAL_Tuple.hpp"
#include "../Types.hpp"
#include "../Memory/pmm.hpp"
#include "../Library/Kstring.hpp"

class FileHandle;
class FileNode;
class VirtualFileSystem;
class VirtualFileSystemManager;
class Process;

enum class ModeRW
{
	Read=0,
	Write=1,
	R=0,
	W=1
};

inline const char * InvalidFileNameCharacter()
{return "/\\:*?\"<>|";}

inline bool IsValidFileNameCharacter(char ch)
{return POS::NotInSet(ch,'/','\\',':','*','?','\"','<','>','|');}

class FileNode
{
	friend class VirtualFileSystemManager;
	public:
		enum:Uint64
		{
			A_Dir		=1ull<<0,
			A_Root		=1ull<<1,
			A_VFS		=1ull<<2,
			A_Device	=1ull<<3,
			A_Temp		=1ull<<4,
			A_LINK		=1ull<<5,
			A_Specical	=1ull<<6,
		};
		
		enum:Uint64
		{
			F_OutsideName=1ull<<0,
			F_BelongVFS  =1ull<<1,
			F_Managed    =1ull<<2,
			F_Base       =1ull<<3,
			F_AutoClose  =1ull<<4
		};
		
	protected:
		VirtualFileSystem *Vfs=nullptr;
		char *Name=nullptr;
		Uint64 Attributes=0;
		Uint64 Flags=0;
		FileNode *fa=nullptr,
				 *pre=nullptr,
				 *nxt=nullptr,
				 *child=nullptr;
		Uint64 FileSize=0;
		Sint32 RefCount=0;
		
		virtual inline void SetFileName(char *name,bool outside){
			if (Name!=nullptr&&!(Flags&F_OutsideName))
				kfree(Name);
			if (outside){
				Flags|=F_OutsideName;
				Name=name;
			}
			else{
				Flags&=~F_OutsideName;
				Name=strdump(name);
			}
		}
		
		void SetFa(FileNode *_fa){
			ASSERTEX(_fa==nullptr||(_fa->Attributes&A_Dir),"FileNode::SetFa "<<_fa<<" of "<<Name<<" is not valid!");
			if (fa!=nullptr){
				if (fa->child==this)
					fa->child=nxt;
				else if (pre!=nullptr)
					pre->nxt=nxt;
				if (nxt!=nullptr)
					nxt->pre=pre;
				pre=nxt=fa=nullptr;
			}
			if (_fa!=nullptr){
				fa=_fa;
				nxt=fa->child;
				fa->child=this;
				if (nxt!=nullptr)
					nxt->pre=this;
			}
		}
		
		template <int type> Uint64 GetPath_Measure(){
			if (Attributes&A_Root)
				return 0;
			else if (type==1&&(Attributes&A_VFS))
				return 0;
			else if (fa==nullptr)
				return 0;
			else return fa->GetPath_Measure<type>()+1+strlen(Name);
		}
		
		template <int type> char* GetPath_Copy(char *dst){
			if (Attributes&A_Root)
				return dst;
			else if (type==1&&(Attributes&A_VFS))
				return dst;
			else if (fa==nullptr)
				return dst;
			else{
				char *s=fa->GetPath_Copy<type>(dst);
				*s='/';
				return strcpyre(s+1,Name);
			}
		}
		
	public:
		virtual Sint64 Read(void *dst,Uint64 pos,Uint64 size)
		{return ERR_UnsuppoertedVirtualFunction;}
		
		virtual Sint64 Write(void *src,Uint64 pos,Uint64 size)
		{return ERR_UnsuppoertedVirtualFunction;}
		
		template <int type> char* GetPath(){
			Uint64 len=GetPath_Measure<type>();
			if (len==0)
				return strdump("/");
			char *re=(char*)kmalloc(len+1);
			*GetPath_Copy<type>(re)=0;
			return re;
		}
		
		virtual Uint64 Size()
		{return FileSize;}
		
		virtual ErrorType Ref(FileHandle *f){
			++RefCount;
			return ERR_None;
		}
		
		virtual ErrorType Unref(FileHandle *f){
			--RefCount;
			if (RefCount<=0&&(Flags&F_AutoClose))
				delete this;
			return ERR_None;
		}
		
		inline const char* GetName() const
		{return Name;}
		
		inline Uint64 GetAttributes() const
		{return Attributes;}
		
		inline bool IsDir() const
		{return Attributes&A_Dir;}
		
		virtual ~FileNode(){
			while (child)
				delete child;
			SetFa(nullptr);
			SetFileName(nullptr,0);
		}
		
		FileNode(VirtualFileSystem *_vfs,Uint64 attri,Uint64 flags):Vfs(_vfs),Attributes(attri),Flags(flags){
			if (Vfs!=nullptr)
				Flags|=F_BelongVFS;
		}
};

class FileHandle:public POS::LinkTableT<FileHandle>
{
	friend class Process;
	public:

		enum
		{
			F_Read	=1ull<<0,
			F_Write	=1ull<<1,
			F_Seek	=1ull<<2,
			F_Size	=1ull<<3, 
			
			F_ALL   =F_Read|F_Write|F_Seek|F_Size
		};
	
		enum
		{
			Seek_Beg=0,
			Seek_Cur,
			Seek_End,
		};
	
	protected:
		FileNode *file=nullptr;
		Uint64 Pos=0;
		Uint64 Flags=0;
		
		Process *proc=nullptr;
		Uint32 FD=-1;
		
	public:
		inline Sint64 Read(void *dst,Uint64 size,Uint64 pos=-1){
			if (!(Flags&F_Read))
				return -ERR_InvalidFileHandlePermission;
			auto err=file->Read(dst,pos==-1?Pos:pos,size);
			if (err>=0&&pos==-1)
				Pos+=err;
			return err;
		}
		
		inline Sint64 Write(void *src,Uint64 size,Uint64 pos=-1){
			if (!(Flags&F_Write))
				return -ERR_InvalidFileHandlePermission;
			auto err=file->Write(src,pos==-1?Pos:pos,size);
			if (err>=0&&pos==-1)
				Pos+=err;
			return err;
		}
		
		inline ErrorType Seek(Sint64 pos,Uint8 base=Seek_Beg,bool forceseek=0){
			if (!(Flags&F_Seek))
				return -ERR_InvalidFileHandlePermission;
			switch (base){
				case Seek_Beg:							break;
				case Seek_Cur: pos+=Pos; 				break;
				case Seek_End: pos+=file->Size();		break;
				default:	return ERR_InvalidParameter;
			}
			if (!POS::InRange(pos,0,file->Size())&&!forceseek)
				return ERR_FileSeekOutOfRange;
			Pos=pos;
			return ERR_None;
		}
		
		inline Uint64 GetPos() const
		{return Pos;}
		
		inline Sint64 Size(){
			if (!(Flags&F_Size))
				return -ERR_InvalidFileHandlePermission;
			return file->Size();
		}
		
		inline FileNode* Node()
		{return file;}
		
		inline int GetFD()
		{return FD;}
		
		inline Uint64 GetFlags()
		{return Flags;}
		
		ErrorType Close(){
		}
		
		ErrorType BindToProcess(Process *_proc,int fd=-1){
			
		}
		
		FileHandle* Dump(){
			FileHandle *re=new FileHandle(file,Flags);
			re->Pos=Pos;
			return re;
		}
		
		~FileHandle()
		{Close();}
		
		FileHandle(FileNode *filenode,Uint64 flags=F_ALL):Flags(flags){
			ASSERTEX(filenode,"Construct FileHandle "<<this<<" from nullptr FileNode with flags "<<(void*)flags);
			file=filenode;
			file->Ref(this);
			LinkTableT<FileHandle>::Init();
		}
};

class VirtualFileSystemManager
{
	protected:
		FileNode *root;
		POS::LinkTable <PAL_DS::Doublet<char*,char*> > SymbolLinks;//Only after normalize path, it will be active.
		bool EnableSymbolLinks;
		
		void AddNewNode(FileNode *p,FileNode *fa);
		FileNode* AddFileInVFS(FileNode *p,char *name);
		FileNode* FindChildName(FileNode *p,const char *s,const char *e);
		FileNode* FindChildName(FileNode *p,const char *s);
		FileNode* FindRecursive(FileNode *p,const char *path);
		PAL_DS::Doublet <VirtualFileSystem*,const char*> FindPathOfVFS(FileNode *p,const char *path);
		char* GetSymbolLinkedPath(const char *path);//if not SymbolLinked, return nullptr
				
	public:
		inline bool IsAbsolutePath(const char *path)
		{return path!=nullptr&&*path=='/';}
		
		char* NormalizePath(const char *path,const char *base=nullptr);//if base is nullptr, or path is absolute, base will be ignored.
		FileNode* FindFile(const char *path,const char *name);
		int GetAllFileIn(const char *path,char *result[],int bufferSize,int skipCnt=0);//if unused ,user should free the char*
		int GetAllFileIn(const char *path,FileNode *result[],int bufferSize,int skipCnt=0);
		int GetAllFileIn(Process *proc,const char *path,char *result[],int bufferSize,int skipCnt=0);
		ErrorType Unlink(const char *path);
		ErrorType Unlink(Process *proc,const char *path);
		ErrorType CreateDirectory(const char *path);
		ErrorType CreateDirectory(Process *proc,const char *path);
		ErrorType CreateFile(const char *path);
		ErrorType CreateFile(Process *proc,const char *path);
		ErrorType Move(const char *src,const char *dst);
		ErrorType Copy(const char *src,const char *dst);
		ErrorType Delete(const char *path);
		ErrorType Delete(FileNode *node);
		ErrorType LoadVFS(VirtualFileSystem *vfs,const char *path="/VFS");
		
		FileNode* Open(const char *path);//path here should be normalized.
		FileNode* Open(Process *proc,const char *path);
		ErrorType Close(FileNode *p);
		
		ErrorType CreateSymbolLink(const char *src,const char *dst);//src and dst should be normalized path
		ErrorType RemoveSymbolLink(const char *src);
		inline void SetEnableSymbolLinks(bool enable)
		{EnableSymbolLinks=enable;}
		
		ErrorType Init();
		ErrorType Destroy();
};
extern VirtualFileSystemManager VFSM;

class VirtualFileSystem
{
//	protected:
	public:
		virtual FileNode* FindFile(FileNode *p,const char *name){
			char *path=p->GetPath<1>();
			FileNode *re=FindFile(path,name);
			kfree(path);
			return re;
		}
		
		virtual int GetAllFileIn(FileNode *p,char *result[],int bufferSize,int skipCnt=0){
			char *path=p->GetPath<1>();

			int re=GetAllFileIn(path,result,bufferSize,skipCnt);

			kfree(path);
			return re;
		}

		virtual int GetAllFileIn(FileNode *p,FileNode *result[],int bufferSize,int skipCnt=0){
			char *path=p->GetPath<1>();

			int re=GetAllFileIn(path,result,bufferSize,skipCnt);

			kfree(path);
			return re;
		}

		virtual FileNode* FindFile(const char *path,const char *name)=0;
		virtual int GetAllFileIn(const char *path,char *result[],int bufferSize,int skipCnt=0)=0;//if unused,result should be empty when input , user should free the char*
		virtual int GetAllFileIn(const char* path, FileNode * nodes[], int bufferSize, int skipCnt = 0) = 0;
		virtual ErrorType CreateDirectory(const char *path)=0;
		virtual ErrorType CreateFile(const char *path)=0;
		virtual ErrorType Move(const char *src,const char *dst)=0;
		virtual ErrorType Copy(const char *src,const char *dst)=0;
		virtual ErrorType Delete(const char *path)=0;
		virtual FileNode* GetNextFile(const char *base)=0;
		
		virtual FileNode* Open(const char *path)=0;
		virtual ErrorType Close(FileNode *p)=0;
		
	public://Path parameter in VFS is relative path to the VFS root.
		virtual const char *FileSystemName()=0;

		virtual ~VirtualFileSystem(){
			using namespace POS;
			kout[Test]<<"VirtualFileSystem Deconstruct"<<endl;
		}
		
		VirtualFileSystem(){
			using namespace POS;
			kout[Test]<<"VirtualFileSystem Construct"<<endl;
		}
};

#endif
