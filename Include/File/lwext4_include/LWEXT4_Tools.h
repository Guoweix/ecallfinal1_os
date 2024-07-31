#ifndef POS_LWEXT4_TOOLS_H
#define POS_LWEXT4_TOOLS_H

#ifdef __cplusplus
extern "C"{
#endif

#include <stddef.h>

// typedef unsigned long long size_t;
void EXT4_Debug(unsigned long long m,const char *fmt);
void EXT4_Debug_s(unsigned long long m,const char *fmt,const char *s);
void EXT4_Debug_u16(unsigned long long m,const char *fmt,unsigned short u);
void EXT4_Debug_i32(unsigned long long m,const char *fmt,int i);
void EXT4_Debug_u32(unsigned long long m,const char *fmt,unsigned u);
void EXT4_Debug_u64(unsigned long long m,const char *fmt,unsigned long long u);
void EXT4_Debug_x(unsigned long long m,const char *fmt,void *x);


void EXT4_Debug_u32_u32(unsigned long long m,const char *fmt,unsigned u1,unsigned u2);
void EXT4_Debug_u64_u32(unsigned long long m,const char *fmt,unsigned long long u1,unsigned u2);
void EXT4_Debug_s_i64(unsigned long long m,const char *fmt,const char *s,long long i);
void EXT4_Debug_u32_u64_u32(unsigned long long m,const char *fmt,unsigned u1,unsigned long long u2,unsigned u3);
void EXT4_Debug_u32_u64_i32(unsigned long long m,const char *fmt,unsigned u1,unsigned long long u2,int u3);
void EXT4_Debug_i32_u64_td_td(unsigned long long m,const char *fmt,int i,unsigned long long u,long long td1,long long td2);
void EXT4_Debug_02x(unsigned long long m,const char *fmt,unsigned char x);
void EXT4_Debug_04x(unsigned long long m,const char *fmt,unsigned short x);
void EXT4_Debug_08x(unsigned long long m,const char *fmt,unsigned int x);

void EXT4_AssertFailed(const char *file,int line,const char *info);

#define ext4_assert(_v)								\
	do												\
	{												\
		if (!(_v))									\
		{											\
			EXT4_AssertFailed(__FILE__,__LINE__,"");\
		}											\
	} while (0)

# define PRIu8		"u"
# define PRIu16		"u"
# define PRIu32		"u"
# define PRIu64	    "lu"

# if __WORDSIZE == 64
#  define __PRI64_PREFIX	"l"
#  define __PRIPTR_PREFIX	"l"
# else
#  define __PRI64_PREFIX	"ll"
#  define __PRIPTR_PREFIX
# endif

# define PRId8		"d"
# define PRId16		"d"
# define PRId32		"d"
# define PRId64		__PRI64_PREFIX "d"

/* lowercase hexadecimal notation.  */
# define PRIx8		"x"
# define PRIx16		"x"
# define PRIx32		"x"
# define PRIx64		__PRI64_PREFIX "x"

#ifndef _FILE_DEFINED
    #define _FILE_DEFINED
    typedef struct _iobuf
    {
        void* _Placeholder;
    } FILE;
#endif

#define SEEK_CUR    1
#define SEEK_END    2
#define SEEK_SET    0

// void* s, char ch, Uint64 size
void *memset(void *str, char c, size_t n) ;
void *memcpy(void *str1, const void *str2, size_t n);
void *memmove(void *str1, const void *str2, size_t n);
int memcmp(const void *str1, const void *str2, size_t n);
size_t strlen(const char *str);
char *strncpy(char *dest, const char *src, size_t n);
void free(void *ptr);
void *malloc(size_t size);
void *calloc(size_t nitems, size_t size);
int strncmp(const char *str1, const char *str2, size_t n);
char *strcpy(char *dest, const char *src);
int strcmp(const char *str1, const char *str2);
void qsort(void *base, size_t nitems, size_t size, int (*compar)(const void *, const void *));


#ifdef __cplusplus
}
#endif

#endif
