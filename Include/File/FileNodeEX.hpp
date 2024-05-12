#ifndef POS_FILENODEEX_HPP
#define POS_FILENODEEX_HPP

#include "FileSystem.hpp"
#include "../Library/Kstring.hpp"
#include "../Memory/vmm.hpp"
#include "../Synchronize/Synchronize.hpp"

class UartFileNode:public FileNode
{
	public:
		virtual Sint64 Read(void *dst,Uint64 pos,Uint64 size){
			char *s=(char*)dst,*e=s+size;
			while (s!=e)
				*s++=getchar();
			return size;
		}
		
		virtual Sint64 Write(void *src,Uint64 pos,Uint64 size){
			using namespace POS;
			char *s=(char*)src,*e=s+size;
			while (s!=e)
				putchar(*s++);
			return size;
		}
		
		UartFileNode():FileNode(nullptr,A_Device|A_Specical,F_Managed){
			SetFileName("stdIO",1);
		}
};
extern UartFileNode *stdIO;

class ZeroFileNode:public FileNode{
	public:
		virtual Sint64 Read(void *dst,Uint64,Uint64 size){
			POS::MemsetT<char>((char*)dst,0,size);
			return size;
		}
		
		virtual Sint64 Write(void*,Uint64,Uint64 size)
		{return size;}
		
		ZeroFileNode():FileNode(nullptr,A_Specical,F_Managed){
			SetFileName("Zero",1);
		}
};

class PipeFileNode:public FileNode
{
	protected:
		Semaphore Lock,SemR,SemW;
		Sint32 WriterCount=0;
		char *buffer=nullptr;
		Uint64 BufferSize=0;
		Uint64 PosR=0,
			   PosW=0;
		
	public:
		virtual Sint64 Read(void *dst,Uint64 pos,Uint64 size){
			Uint64 size_bak=size;
			bool flag=0;
			while (size>0){
				Lock.wait();
				if (FileSize>0){
					while (size>0&&FileSize>0){
						*(char*)dst++=buffer[PosR++];
						--FileSize;
						--size;
						if (PosR==BufferSize)
							PosR=0;
					}
					SemW.signal();
					Lock.signal();
				}
				else{
				    flag=1;
					Lock.signal();
					if (flag){
						SemR.signal();//
						return size_bak-size;
					}
					else SemR.wait();
				}
			}
			return size_bak;
		}
		
		virtual Sint64 Write(void *src,Uint64 pos,Uint64 size){
			Uint64 size_bak=size;
			while (size>0){
				Lock.wait();
				if (FileSize<BufferSize){
					while (size>0&&FileSize<BufferSize){
						buffer[PosW++]=*(char*)src++;
						++FileSize;
						--size;
						if (PosW==BufferSize)
							PosW=0;
					}
					SemR.signal();
					Lock.signal();
				}
				else{
					Lock.signal();
					SemW.wait();
				}
			}
			return size_bak;
		}
		
		virtual inline ErrorType Ref(FileHandle *f){
			FileNode::Ref(f);
			if (f->GetFlags()&FileHandle::F_Write)
				++WriterCount;
			return ERR_None;
		}
		
		virtual inline ErrorType Unref(FileHandle *f){
			if (f->GetFlags()&FileHandle::F_Write)
				--WriterCount;
			FileNode::Unref(f);
			return ERR_None;
		}
		
		virtual ~PipeFileNode(){
			delete[] buffer;
		}
		
		PipeFileNode(const char *name=nullptr,Uint64 bufferSize=4096)
		:FileNode(nullptr,0,F_AutoClose),BufferSize(bufferSize){
			Lock.init(1);//
			SemR.init(0);//
			SemW.init(0);//
			if (name!=nullptr)
				SetFileName((char*)name,0);
			buffer=new char[BufferSize];
		}
};

class TempFileNode:public FileNode{
	protected:
		static constexpr Uint64 FragmentSize=PAGESIZE;
		
		struct DataFragment{
			Uint64 size=0,
				   capacity=0,
				   pos=0;
			DataFragment *nxt=nullptr;
			char *data=nullptr;
			
			DataFragment* Extend(){
				if (nxt!=nullptr)
					return nxt->Extend();
				else if (size!=capacity)
					return nullptr;
				else return nxt=new DataFragment(pos+capacity);
			}
			
			~DataFragment(){
				delete nxt;
				delete[] data;
			}
			
			DataFragment(Uint64 _pos,Uint64 _cap=FragmentSize):pos(_pos),capacity(_cap){
				data=new char[capacity];
			}
		};
		DataFragment *HeadFragment=nullptr,
					 *DataCache=nullptr;
		Mutex lock; 
		
		DataFragment *Find(Uint64 pos){
			if (DataCache!=nullptr&&POS::InRange(pos,DataCache->pos,DataCache->pos+DataCache->capacity-1))
				return DataCache;
			for (DataFragment *p=DataCache!=nullptr&&pos>DataCache->pos?DataCache:HeadFragment;p;p=p->nxt)
				if (POS::InRange(pos,p->pos,p->pos+p->capacity-1))
					return DataCache=p;
			return nullptr;
		}
		
	public:
		virtual Sint64 Read(void *dst,Uint64 pos,Uint64 size){
			lock.Lock();
			Uint64 size_bak=size;
			char *s=(char*)dst;
			while (size)
				if (DataFragment *p=Find(pos);p!=nullptr){
					Uint64 len=POS::minN(size,p->pos+p->size-pos);
					if (len==0)
						break;
					POS::MemcpyT(s,p->data+pos-p->pos,len);
					s+=len;
					pos+=len;
					size-=len;
				}
				else break;
			lock.Unlock();
			return size_bak-size;
		}
		
		virtual Sint64 Write(void *src,Uint64 pos,Uint64 size){
			using namespace POS;
			lock.Lock();
			ErrorType re=0;
			if (pos>FileSize)
				re=-ERR_FileOperationOutofRange;
			else
			{
				Uint64 size_bak=size;
				const char *s=(const char*)src;
				while (size)//Need improve?
					if (DataFragment *p=Find(pos);p!=nullptr){
						Uint64 len=minN(size,p->pos+p->capacity-pos);
						MemcpyT(p->data+pos-p->pos,s,len);
						p->size=maxN(p->size,pos-p->pos+len);
						s+=len;
						pos+=len;
						size-=len;
						FileSize=maxN(FileSize,pos);
					}
					else if (HeadFragment==nullptr)
						HeadFragment=new DataFragment(0);
					else if ((DataCache=HeadFragment->Extend())==nullptr)
						kout[Fault]<<"TempFileNode "<<this<<" failed to extend!"<<endl;
				re=size_bak-size;
			}
			lock.Unlock();
			return re;
		}
		
		virtual ~TempFileNode(){
			delete HeadFragment;
		}
		
		TempFileNode(const char *name):FileNode(nullptr,A_Temp,F_Managed){
			if (name!=nullptr)
				SetFileName((char*)name,0);
		}
};

class MemapFileRegion:public VirtualMemoryRegion{
	protected:
		FileNode *File=nullptr;
		Uint64 StartAddr=0,
			   Length=0,
			   Offset=0;
		
	public:
		ErrorType Save(){
			VirtualMemorySpace *old=VirtualMemorySpace::Current();
			VMS->Enter();
			VMS->EnableAccessUser();
			Sint64 re=File->Write((void*)StartAddr,Offset,Length);
			VMS->DisableAccessUser();
			old->Enter();
			return re>=0?ERR_None:-re;
		}
		
		ErrorType Load(){
			CALLINGSTACKS("MemapFileRegion::Load");
			VirtualMemorySpace *old=VirtualMemorySpace::Current();
			VMS->Enter();
			VMS->EnableAccessUser();
			Sint64 re=File->Read((void*)StartAddr,Offset,Length);
			VMS->DisableAccessUser();
			old->Enter();
			return re>=0?ERR_None:-re;
		}
		
		ErrorType Resize(Uint64 len){
			if (len==Length)
				return ERR_None;
			if (len>Length)
				if (nxt!=nullptr&&(StartAddr+len>nxt->GetStart()||StartAddr+len>0x70000000))
					return ERR_InvalidRangeOfVMR;
			Length=len;
			EndAddress=StartAddr+Length+PAGESIZE-1>>12<<12;
			return ERR_None;
		}
		
		inline Uint64 GetStartAddr() const
		{return StartAddr;}
		
		~MemapFileRegion(){
			File->Unref(nullptr);
			if (VMS!=nullptr)
				VMS->RemoveVMR(this,0);
		}
		
		MemapFileRegion(FileNode *node,void *start,Uint64 len,Uint64 offset,Uint32 prot)
		:File(node),StartAddr((PtrUint)start),Length(len),Offset(offset)
		{
			ASSERTEX(VirtualMemoryRegion::Init((PtrUint)start,(PtrUint)start+len,prot)==ERR_None,"MemapFileRegion "<<this<<" failed to init VMR!");
			node->Ref(nullptr);
		}
};

#endif
