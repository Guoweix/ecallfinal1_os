#include "Arch/Riscv.hpp"
#include "Types.hpp"
#include <File/FileEx.hpp>

PIPEFILE::PIPEFILE()
    : FileNode()
{
    kout << "PIPEFILE init" << endl;
    TYPE = __PIPEFILE;
    readRef = 2;
    writeRef = 2;
    in = 0, out = 0;
    file = new Semaphore(1);
    full = new Semaphore(0);
    empty = new Semaphore(FILESIZE - 1);
}
PIPEFILE::~PIPEFILE()
{
}

Sint64 PIPEFILE::read(void* buf_, Uint64 pos, Uint64 size)
{
    unsigned char* buf = (unsigned char*)buf_;

    kout[Info] << "pipe read didn't solved" << endl;
    for (int i = 0; i < size; i++) {
        full->wait();
        if (full->getValue() < 0) {
            pm.immSchedule();
        }
        file->wait();
        if (file->getValue() < 0) {
            pm.immSchedule();
        }

        buf[i] = data[out];
        kout[Info] << (int)data[out] << endl;
        if (data[out] == 4) {
            file->signal();
            empty->signal();
            // kout[Fault]<<"EOF "<<endl;
            return false;
        }
        out = (out + 1) % FILESIZE;

        file->signal();
        empty->signal();
    }

    return size;
}
Sint64 PIPEFILE::write(void* src_, Uint64 size)
{

    unsigned char* src = (unsigned char*)src_;
    kout[Info] << "pipe write didn't solved" << endl;

    for (int i = 0; i < size; i++) {
        empty->wait();
        if (empty->getValue() < 0) {
            pm.immSchedule();
        }
        file->wait();
        if (file->getValue() < 0) {
            pm.immSchedule();
        }
        data[in] = src[i];
        kout[Info] << "IN" << in << endl;
        in = (in + 1) % FILESIZE;

        file->signal();
        full->signal();
    }
    return size;
}

Sint64 UartFile::read(void* buf, Uint64 size)
{
    char* s = (char*)buf;
    s[0] = getchar();
			// while ((ch=SBI_GETCHAR())==-1);

    // #ifdef __ECHO
    // SBI_PUTCHAR(s[0]);
    // #endif

    if (s[0] == '\r') {
        s[0] = '\n';
        // return 2;
    }
    return 1;
}

Sint64 UartFile::write(void* src, Uint64 size)
{
    char* end = (char*)src + size;
    char* start = (char*)src;
    while (start != end) {
        putchar(*start);
        start++;
    }
    return size;
}

Sint64 UartFile::read(void* buf, Uint64 pos, Uint64 size)
{
    return read(buf, size);
}

Sint64 UartFile::write(void* src, Uint64 pos, Uint64 size)
{
    return write(src, size);
}

UartFile* STDIO;