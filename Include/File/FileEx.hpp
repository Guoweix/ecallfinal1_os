#ifndef __FILE_EX_HPP_
#define __FILE_EX_HPP_

#include "Driver/Memlayout.hpp"
#include "Library/KoutSingle.hpp"
#include "Types.hpp"
#include <File/vfsm.hpp>
#include <Memory/vmm.hpp>
#include <Synchronize/Synchronize.hpp>
#define __ECHO

class MemapFileRegion : public VirtualMemoryRegion {
protected:
    FileNode* File = nullptr;
    Uint64 StartAddr = 0,
           Length = 0,
           Offset = 0;

public:
    ErrorType Save() // Save memory to file
    {
        VirtualMemorySpace* old = VirtualMemorySpace::Current();
        VMS->Enter();
        VMS->EnableAccessUser();
        Uint64 re = 0;
        kout << Red << "Save" << endl;
        // Sint64 re=File->write((unsigned char *)StartAddr,Offset,Length);
        VMS->DisableAccessUser();
        old->Enter();
        return re >= 0 ? ERR_None : -re; //??
    }

    ErrorType Load() // Load memory from file
    {
        VirtualMemorySpace* old = VirtualMemorySpace::Current();
        VMS->Enter();
        VMS->EnableAccessUser();
        Sint64 re = File->read((unsigned char*)StartAddr, Offset, Length);
        VMS->DisableAccessUser();
        old->Enter();
        return re >= 0 ? ERR_None : -re;
    }

    ErrorType Resize(Uint64 len)
    {
        if (len == Length)
            return ERR_None;
        if (len > Length)
            if (nxt != nullptr && (StartAddr + len > nxt->GetStart() || StartAddr + len > 0x70000000))
                return ERR_InvalidRangeOfVMR;
        Length = len;
        EndAddress = StartAddr + Length + PAGESIZE - 1 >> PageSizeBit << PageSizeBit;
        //<<Free pages not in range...
        return ERR_None;
    }

    inline Uint64 GetStartAddr() const
    {
        return StartAddr;
    }

    ~MemapFileRegion() // Virtual??
    {
        vfsm.close(File);
        if (VMS != nullptr)
            VMS->RemoveVMR(this, 0);
    }

    MemapFileRegion(FileNode* node, void* start, Uint64 len, Uint64 offset, Uint32 prot)
        : VirtualMemoryRegion((PtrUint)start, (PtrUint)start + len, prot)
        , File(node)
        , StartAddr((PtrSint)start)
        , Length(len)
        , Offset(offset)
    {
        Flags|=VM_MmapFile;
        ASSERTEX(VirtualMemoryRegion::Init((PtrSint)start, (PtrSint)start + len, prot) == ERR_None, "MemapFileRegion " << this << " failed to init VMR!");
        vfsm.open(File);
    }
};

class PIPEFILE : public FileNode {
public:
    PIPEFILE();
    ~PIPEFILE();

    enum : Uint32 {
        FILESIZE = 1 << 12,
    };

    bool flag=0;
    Uint32 PipeSize=0;
    Uint32 readRef;
    Uint32 writeRef;
    Uint32 in, out;
    Uint8 data[FILESIZE];
    Semaphore *file, *full, *empty;
    Sint64 read(void* buf, Uint64 pos, Uint64 size) override;
    Sint64 read(void* buf, Uint64 size) override;
    Sint64 write(void* src, Uint64 pos, Uint64 size) override;
    Sint64 write(void* src, Uint64 size) override;
};

class UartFile : public FileNode {

    bool isFake = 0;

public:
    UartFile()
    {
        TYPE |= FileType::__DEVICE;
        RefCount = 1e9;
    };
    ~UartFile() {};

    void setFakeDevice(bool _isFake) { isFake = _isFake; };
    virtual Sint64 read(void* buf, Uint64 size) override;
    virtual Sint64 write(void* src, Uint64 size) override;
    virtual Sint64 read(void* buf, Uint64 pos, Uint64 size) override;
    virtual Sint64 write(void* src, Uint64 pos, Uint64 size) override;
};
/* 
class PIPEFILE : public FileNode {
protected:
    Semaphore Lock, SemR, SemW;
    char* buffer = nullptr;
    Uint64 BufferSize = 0;
    Uint64 PosR = 0,
           PosW = 0;

public:
    Sint32 writeRef = 0;
    Sint32 readRef = 0;
    virtual Sint64 read(void* dst, Uint64 pos, Uint64 size) override
    {
        Uint64 size_bak = size;
        bool flag = 0;
        while (size > 0) {
            Lock.wait();
            if (fileSize > 0) {
                while (size > 0 && fileSize > 0) {
                    *(char*)dst++ = buffer[PosR++];
                    --fileSize;
                    --size;
                    if (PosR == BufferSize)
                        PosR = 0;
                }
                SemW.signal(); //??
                Lock.signal();
            } else {
                //					if (WriterCount==0)//??
                flag = 1;
                Lock.signal();
                if (flag) {
                    while (SemR.getValue() < 0) {
                        SemR.signal();
                    }
                    return size_bak - size;
                } else
                    SemR.wait();
            }
        }
        return size_bak;
    }

    virtual Sint64 write(void* src, Uint64 pos, Uint64 size) override // pos is not used...
    {
        Uint64 size_bak = size;
        while (size > 0) {
            Lock.wait();
            if (fileSize < BufferSize) {
                while (size > 0 && fileSize < BufferSize) {
                    buffer[PosW++] = *(char*)src++;
                    ++fileSize;
                    --size;
                    if (PosW == BufferSize)
                        PosW = 0;
                }
                SemR.signal(); //??
                Lock.signal();
            } else {
                Lock.signal();
                SemW.wait();
            }
        }
        return size_bak;
    }

    virtual ~PIPEFILE()
    {
        delete[] buffer;
    }

    PIPEFILE(const char* name = nullptr, Uint64 bufferSize = 4096)
        : FileNode()
        , Lock(1)
        , SemR(0)
        , SemW(0)
        , BufferSize(bufferSize) //??
    {
        // if (name!=nullptr)
        // SetFileName((char*)name,0);
        TYPE = FileType::__PIPEFILE;
        buffer = new char[BufferSize];
    }
};
 */
extern UartFile* STDIO;

#endif