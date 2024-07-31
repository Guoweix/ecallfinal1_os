#include <Library/KoutSingle.hpp>
#include <Memory/pmm.hpp>
using namespace POS;

extern unsigned EXT;

extern "C" {

#include <File/lwext4_include/LWEXT4_Tools.h>

void EXT4_Debug(unsigned long long m, const char* fmt)
{
    kout[EXT] << fmt << endl;
}

void EXT4_Debug_s(unsigned long long m, const char* fmt, const char* s)
{
    kout[EXT] << fmt << s << endl;
}

void EXT4_Debug_u16(unsigned long long m, const char* fmt, unsigned short u)
{
    kout[EXT] << fmt << u << endl;
}

void EXT4_Debug_i32(unsigned long long m, const char* fmt, int i)
{
    kout[EXT] << fmt << i << endl;
}

void EXT4_Debug_u32(unsigned long long m, const char* fmt, unsigned u)
{
    kout[EXT] << fmt << u << endl;
}

void EXT4_Debug_u64(unsigned long long m, const char* fmt, unsigned long long u)
{
    kout[EXT] << fmt << u << endl;
}

void EXT4_Debug_x(unsigned long long m, const char* fmt, void* x)
{
    kout[EXT] << fmt << x << endl;
}

void EXT4_Debug_u32_u32(unsigned long long m, const char* fmt, unsigned u1, unsigned u2)
{
    kout[EXT] << fmt << u1 << u2 << endl;
}

void EXT4_Debug_u64_u32(unsigned long long m, const char* fmt, unsigned long long u1, unsigned u2)
{
    kout[EXT] << fmt << u1 << u2 << endl;
}

void EXT4_Debug_s_i64(unsigned long long m, const char* fmt, const char* s, long long i)
{
    kout[EXT] << fmt << s << i << endl;
}

void EXT4_Debug_u32_u64_u32(unsigned long long m, const char* fmt, unsigned u1, unsigned long long u2, unsigned u3)
{
    kout[EXT] << fmt << u1 << u2 << u3 << endl;
}

void EXT4_Debug_u32_u64_i32(unsigned long long m, const char* fmt, unsigned u1, unsigned long long u2, int u3)
{
    kout[EXT] << fmt << u1 << u2 << u3 << endl;
}

void EXT4_Debug_i32_u64_td_td(unsigned long long m, const char* fmt, int i, unsigned long long u, long long td1, long long td2)
{
    kout[EXT] << fmt << i << u << (void*)td1 << (void*)td2 << endl;
}

void EXT4_Debug_02x(unsigned long long m, const char* fmt, unsigned char x)
{
    kout[EXT] << fmt << (void*)x << endl;
}

void EXT4_Debug_04x(unsigned long long m, const char* fmt, unsigned short x)
{
    kout[EXT] << fmt << (void*)x << endl;
}

void EXT4_Debug_08x(unsigned long long m, const char* fmt, unsigned int x)
{
    kout[EXT] << fmt << (void*)x << endl;
}

void EXT4_AssertFailed(const char* file, int line, const char* info)
{
    kout[Fault] << "EXT4_AssertFailed in file " << file << " line " << line << " with info " << info << endl;
}


// memset: 将指针str指向的内存块的前n个字节设置为指定的值c
/* 
// memcpy: 将指针str2指向的内存区域的前n个字节复制到指针str1指向的内存区域
void* memcpy(void* str1, const void* str2, size_t n)
{
    unsigned char* dest = (unsigned char*)str1;
    const unsigned char* src = (const unsigned char*)str2;
    while (n--) {
        *dest++ = *src++;
    }
    return str1;
}

*/
// memmove: 将指针str2指向的内存区域的前n个字节复制到指针str1指向的内存区域，处理重叠情况
void* memmove(void* str1, const void* str2, size_t n)
{
    unsigned char* dest = (unsigned char*)str1;
    const unsigned char* src = (const unsigned char*)str2;
    if (dest < src) {
        while (n--) {
            *dest++ = *src++;
        }
    } else {
        dest += n;
        src += n;
        while (n--) {
            *(--dest) = *(--src);
        }
    }
    return str1;
}

// memcmp: 比较指针str1和str2指向的内存区域的前n个字节
int memcmp(const void* str1, const void* str2, size_t n)
{
    const unsigned char* p1 = (const unsigned char*)str1;
    const unsigned char* p2 = (const unsigned char*)str2;
    while (n--) {
        if (*p1 != *p2) {
            return *p1 - *p2;
        }
        p1++;
        p2++;
    }
    return 0;
}

/*
// strlen: 计算字符串str的长度，不包括终止的空字符
size_t strlen(const char* str)
{
    const char* s = str;
    while (*s) {
        s++;
    }
    return s - str;
}

int strcmp(const char* str1, const char* str2)
{
    while (*str1 && (*str1 == *str2)) {
        str1++;
        str2++;
    }
    return *(unsigned char*)str1 - *(unsigned char*)str2;
}
 */

// strncpy: 将字符串src的前n个字符复制到dest
char* strncpy(char* dest, const char* src, size_t n)
{
    char* d = dest;
    while (n && (*d++ = *src++)) {
        n--;
    }
    while (n--) {
        *d++ = '\0';
    }
    return dest;
}
extern long long memCount;
// free: 释放动态分配的内存
void free(void* ptr)
{
    if (ptr == nullptr) {
        return;
    }
    memCount--;
    kfree(ptr);
}

// malloc: 动态分配内存
void* malloc(size_t size)
{
    // if (size >= 256 * 1024) {
        // kout[DeBug] << "big mem malloc" << size << endl;
    // }
    memCount++;
    void* memory = kmalloc(size);
    return memory;
}

// calloc: 分配并清零内存
void* calloc(size_t nitems, size_t size)
{

    // if (nitems * size>=256*1024) {
        // kout[DeBug] << "big mem malloc" << size * nitems << endl;
    // }
    memCount++;
    void* memory = kmalloc(size * nitems);
    memset(memory, 0, size * nitems);
    return memory;
}

// strncmp: 比较字符串str1和str2的前n个字符
int strncmp(const char* str1, const char* str2, size_t n)
{
    while (n--) {
        if (*str1 != *str2) {
            return *(unsigned char*)str1 - *(unsigned char*)str2;
        }
        if (!*str1) {
            break;
        }
        str1++;
        str2++;
    }
    return 0;
}

/* 
// strcpy: 将字符串src复制到dest
char* strcpy(char* dest, const char* src)
{
    char* d = dest;
    while ((*d++ = *src++))
        ;
    return dest;
}
 */
static void _qsort(void* base, size_t nitems, size_t size, int (*compar)(const void*, const void*)) // TODO, test it and fix this to quick sort
{
    char* arr = (char*)base;
    for (size_t i = 0; i < nitems - 1; i++)
        for (size_t j = 0; j < nitems - i - 1; j++)
            if (compar(arr + j * size, arr + (j + 1) * size) > 0) {
                char* temp = (char*)kmalloc(size);
                memcpy(temp, arr + j * size, size);
                memcpy(arr + j * size, arr + (j + 1) * size, size);
                memcpy(arr + (j + 1) * size, temp, size);
            }
}

void qsort(void* base, size_t nitems, size_t size, int (*compar)(const void*, const void*))
{
    if (nitems < 2)
        return;
    _qsort(base, nitems, size, compar);
}
};
