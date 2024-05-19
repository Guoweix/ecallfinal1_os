#include <Library/Kstring.hpp>

Uint64 strlen(const char* s)
{
    Uint64 ret_cnt = 0;
    while (*s++ != '\0')
    {
        ret_cnt++;
    }
    return ret_cnt;
}

// 直接在参数里修改
void strcpy(char* dst, const char* src)
{
    while (*src != '\0')
    {
        *dst = *src;
        src++;
        dst++;
    }
    *dst = '\0';
}

char* strdump(const char *src)
{
	auto len=strlen(src);
	if (len==0)
		return nullptr;
	char *re=new char[len+1];
	strcpy(re,src);
	return re;
}

// 用返回值作为修改后的字符串
char* strcpy_s(char* dst, const char* src)
{
    char* p = dst;
    while ((*p++ = *src++) != '\0')
    {
        //do nothing ...
    }
    *p = 0;

    return dst;
}

void strcpy3(char *dst,const char *src,const char *end)
{
	while (src<end)
		*dst++=*src++;
	*dst=0;
}

char* strcpyre(char *dst,const char *src)
{
	while (*src)
		*dst++=*src++;
	return dst;
}

char* strcpy_no_end(char* dst, const char* src)
{
    char* p = dst;
    while (*src != '\0')
    {
        *p = *src;
        p++;
        src++;
    }
    return dst;
}

int strcmp(const char* s1, const char* s2)
{
    while (*s1 != '\0' && *s1 == *s2)
    {
        s1++;
        s2++;
    }
    auto cmp_value = (unsigned char)*s1 - (unsigned char)*s2;
    return (int)cmp_value;
}

void strcat(char* dst, const char* src)
{
    while (*dst != 0)
        dst++;
    strcpy(dst, src);
}


void* memset(void* s, char ch, Uint64 size)
{
    char* p = (char*)s;
    while (size-- > 0)
    {
        *p++ = ch;
    }
    return s;
}

void* memcpy(void* dst, const char* src, Uint64 size)
{
    const char* s = src;
    char* d = (char*)dst;
    while (size-- > 0)
    {
        *d++ = *s++;
    }
    return dst;
}