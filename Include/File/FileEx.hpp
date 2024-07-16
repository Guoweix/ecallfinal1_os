#ifndef __FILE_EX_HPP_
#define __FILE_EX_HPP_

#include "Driver/Memlayout.hpp"
#include "Library/KoutSingle.hpp"
#include "Types.hpp"
#include <File/vfsm.hpp>
#include <Memory/vmm.hpp>
#include <Synchronize/Synchronize.hpp>

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
        // File->Unref(nullptr);
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

    Uint32 readRef;
    Uint32 writeRef;
    Uint32 in, out;
    Uint8 data[FILESIZE];
    Semaphore *file, *full, *empty;
    Sint64 read(void* buf, Uint64 pos, Uint64 size);
    Sint64 write(void* src, Uint64 size);
};

class UartFile : public FileNode {

public:
    UartFile(){};
    ~UartFile(){};

    virtual Sint64 read(void* buf, Uint64 size) override;
    virtual Sint64 write(void* src, Uint64 size) override;
    virtual Sint64 read(void* buf, Uint64 pos,Uint64 size) override;
    virtual Sint64 write(void* src, Uint64 pos, Uint64 size) override;
};

extern UartFile * STDIO;
#endif