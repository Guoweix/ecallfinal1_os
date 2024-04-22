#ifndef POS_STRINGTOOLS_HPP
#define POS_STRINGTOOLS_HPP

namespace POS
{
	inline void strCopy(char *dst,const char *src)
	{
		while (*src)
			*dst++=*src++;
		*dst=0;
	}
	
	inline void strCopy(char *dst,const char *src,const char *end)
	{
		while (src<end)
			*dst++=*src++;
		*dst=0;
	}
	
	inline char* strCopyRe(char *dst,const char *src)
	{
		while (*src)
			*dst++=*src++;
		return dst;
	}
	
	inline int strComp(const char *s1,const char *s2)
	{
		while (*s1&&*s1==*s2)
			++s1,++s2;
		if (*s1==*s2)
			return 0;
		else if (*s1==0)
			return -1;
		else if (*s2==0)
			return 1;
		else if (*s1<*s2)
			return -1;
		else return 1;
	}
	
	inline int strComp(const char *s1,const char *se1,const char *s2)//??
	{
		while (s1<se1&&*s2&&*s1==*s2)
			++s1,++s2;
		if (s1==se1&&*s2==0)
			return 0;
		else if (s1==se1)
			return -1;
		else if (*s2==0)
			return 1;
		else if (*s1==*s2)
			return 0;
		else if (*s1<*s2)
			return -1;
		else return 1;
	}
	
	inline int strComp(const char *s1,const char *se1,const char *s2,const char *se2)//??
	{
		while (s1<se1&&s2<se2&&*s1==*s2)
			++s1,++s2;
		if (s1==se1&&s2==se2)
			return 0;
		else if (s1==se1)
			return -1;
		else if (s2==se2)
			return 1;
		else if (*s1==*s2)
			return 0;
		else if (*s1<*s2)
			return -1;
		else return 1;
	}
	
	inline unsigned long long strLen(const char *src)
	{
		if (src==nullptr) return 0;
		unsigned long long re=0;
		while (src[re]!=0)
			++re;
		return re;
	}
	
	inline const char* strFind(const char *s,char ch)
	{
		while (*s)
			if (*s==ch)
				return s;
			else ++s;
		return nullptr;
	}
	
	template <typename ...Ts> inline unsigned long long strLen(const char *src,const Ts *...others)
	{return strLen(src)+strLen(others...);}
	
	inline bool IsUpperCase(char ch)
	{return 'A'<=ch&&ch<='Z';}
	
	inline bool IsLowerCase(char ch)
	{return 'a'<=ch&&ch<='z';}
	
	inline bool IsLetter(char ch)
	{return IsUpperCase(ch)||IsLowerCase(ch);}
};

#endif
