#ifndef POS_KOUTSINGLE_HPP
#define POS_KOUTSINGLE_HPP
#include <Library/SBI.h>
/*
        KoutSingle(or Kout All in one)
        By:qianpinyi

        To used this library, you should implement "Putchar" declared below and define "KOUT kout" in one compile unit which is also mentioned in the end of this file.
*/

#include "Arch/Riscv.hpp"
#include "Library/Pathtool.hpp"
extern "C" {
void Putchar(char ch);
};

namespace POS {
using Uint64 = unsigned long long;

inline void Puts(const char* s)
{
    if (s == nullptr)
        return;
    while (*s)
        Putchar(*s++);
}

template <typename T>
void MemsetT(T* dst, const T& val, unsigned long long count)
{
    if (dst == nullptr || count == 0)
        return;
    T* end = dst + count;
    while (dst != end)
        *dst++ = val;
}

template <typename T>
void MemcpyT(T* dst, const T* src, unsigned long long count)
{
    if (dst == nullptr || src == nullptr || dst == src || count == 0)
        return;
    T* end = dst + count;
    while (dst != end)
        *dst++ = *src++;
}

template <typename T>
inline T minN(const T& a, const T& b)
{
    return b < a ? b : a;
}

template <typename T>
inline T maxN(const T& a, const T& b)
{
    return a < b ? b : a;
}

template <typename T0, typename T1>
inline bool NotInSet(const T0& x, const T1& a)
{
    return x != a;
}

template <typename T0, typename T1, typename... Ts>
inline bool NotInSet(const T0& x, const T1& a, const Ts&... args)
{
    if (x == a)
        return 0;
    else
        return NotInSet(x, args...);
}

template <typename T0, typename T1>
inline bool InThisSet(const T0& x, const T1& a)
{
    return x == a;
}

template <typename T0, typename T1, typename... Ts>
inline bool InThisSet(const T0& x, const T1& a, const Ts&... args)
{
    if (x == a)
        return 1;
    else
        return InThisSet(x, args...);
}

template <typename T>
inline void Swap(T& x, T& y)
{
    T t = x;
    x = y;
    y = t;
}

template <typename T1, typename T2, typename T3>
inline bool InRange(const T1& x, const T2& L, const T3& R)
{
    return L <= x && x <= R;
}

inline int ullTOpadic(char* dst, unsigned size, unsigned long long x, bool isA = 1, unsigned char p = 16, unsigned w = 1)
{
    if (dst == nullptr || size == 0 || p >= 36 || w > size)
        return 0;
    unsigned i = 0;
    while (x && i < size) {
        int t = x % p;
        if (t <= 9)
            t += '0';
        else
            t += (isA ? 'A' : 'a') - 10;
        dst[i++] = t;
        x /= p;
    }
    if (i == size && x)
        return -1;
    if (w != 0)
        while (i < w)
            dst[i++] = '0';
    for (int j = (i >> 1) - 1; j >= 0; --j)
        Swap(dst[j], dst[i - j - 1]);
    return i; //\0 is not added automaticly!
}

class DataWithSize {
public:
    void* data;
    Uint64 size;

    DataWithSize(void* _data, Uint64 _size)
        : data(_data)
        , size(_size)
    {
    }
    DataWithSize() {};
};

class DataWithSizeUnited : public DataWithSize {
public:
    enum // bit 0~7:mode 8~X feature
    {
        F_Hex = 0,
        F_Char = 1,
        F_Mixed = 2,
    };

    Uint64 unitSize;
    Uint64 flags;

    DataWithSizeUnited(void* _data, Uint64 _size, Uint64 _unitsize, Uint64 _flags = F_Hex)
        : DataWithSize(_data, _size)
        , unitSize(_unitsize)
        , flags(_flags)
    {
    }
};

 class DebugLocation {
public:
    const char *file = nullptr,
               *func = nullptr,
               *pretty_func = nullptr;
    const int line = 0;

    DebugLocation(const char* _file, const char* _func, const char* _pretty_func, const int _line)
        : file(_file)
        , func(_func)
        , pretty_func(_pretty_func)
        , line(_line)
    {
    }
};

#define DeBug POS::DebugLocation(nullptr, __func__, nullptr, __LINE__)
#define DEBug POS::DebugLocation(__FILE__, __func__, __PRETTY_FUNCTION__, __LINE__)
namespace KoutEX {
    enum KoutEffect {
        Reset = 0,
        Bold = 1,
        Dim = 2,
        Underlined = 4,
        Blink = 5,
        Reverse = 7,
        Hidden = 8,
        ResetBold = 21,
        ResetDim = 22,
        ResetUnderlined = 24,
        ResetBlink = 25,
        ResetReverse = 27,
        ResetHidden = 28,

        ResetFore = 39,
        Black = 30,
        Red = 31,
        Green = 32,
        Yellow = 33,
        Blue = 34,
        Magenta = 35,
        Cyan = 36,
        LightGray = 37,
        DarkGray = 90,
        LightRed = 91,
        LightGreen = 92,
        LightYellow = 93,
        LightBlue = 94,
        LightMagenta = 95,
        LightCyan = 96,
        White = 97,

        ResetBG = 49,
        BlackBG = 40,
        RedBG = 41,
        GreenBG = 42,
        YellowBG = 43,
        BlueBG = 44,
        MagentaBG = 45,
        CyanBG = 46,
        LightGrayBG = 47,
        DarkGrayBG = 100,
        LightRedBG = 101,
        LightGreenBG = 102,
        LigthYellowBG = 103,
        LigthBlueBG = 104,
        LightMagentaBG = 105,
        LigthCyanBG = 106,
        WhiteBG = 107
    };

    enum KoutType {
        Info = 0,
        Warning = 1,
        Error = 2,
        Debug = 3,
        Fault = 4,
        Test = 5,

        NoneKoutType = 31
    };
};
using namespace KoutEX;

class KOUT {
    friend KOUT& endl(KOUT&);
    friend KOUT& endout(KOUT&);

protected:
    const char* TypeName[32] { "Info", "Warning", "Error", "Debug", "Fault", "Test", 0 };
    KoutEX::KoutEffect TypeColor[32] { KoutEX::Cyan, KoutEX::Yellow, KoutEX::Red, KoutEX::LightMagenta, KoutEX::LightRed, KoutEX::LightCyan, KoutEX::ResetFore };
    unsigned EnabledType = 0xFFFFFFFF;
    unsigned CurrentType = 31;
    unsigned RegisteredType = 0;
    bool CurrentTypeOn = 1,
         EnableEffect = 1;

    inline bool Precheck()
    {
        return CurrentTypeOn;
    }

    inline void SwitchCurrentType(unsigned p)
    {
        CurrentType = p;
        CurrentTypeOn = bool(1u << p & EnabledType);
    }

    inline static void PrintHex(unsigned char x, bool isA = 1)
    {
        if ((x >> 4) <= 9)
            Putchar((x >> 4) + '0');
        else
            Putchar((x >> 4) - 10 + (isA ? 'A' : 'a'));
        if ((x & 0xF) <= 9)
            Putchar((x & 0xF) + '0');
        else
            Putchar((x & 0xF) - 10 + (isA ? 'A' : 'a'));
    }

public:

    inline KOUT& operator[](const DebugLocation& dbg)
    {
        SwitchCurrentType(Debug);
        *this << Reset << TypeColor[Debug] << "[" << dbg.func << ":" << dbg.line << "] ";
        if (dbg.file != nullptr)
            *this << "in file " << dbg.file << ". ";
        if (dbg.pretty_func != nullptr)
            *this << "function " << dbg.pretty_func << ". ";
        return *this;
    }
    inline KOUT& operator[](unsigned p) // Current Kout Info is type p. It will be clear when Endline is set!
    {
        if ((p <= 5 || 7 < p && p <= 7 + RegisteredType) && p <= 31)
            SwitchCurrentType(p);
        else
            SwitchCurrentType(KoutEX::NoneKoutType);
        return *this << Reset << TypeColor[p] << "[" << TypeName[p] << "] ";
    }

    inline KOUT& operator[](const char* type)
    {
        SwitchCurrentType(KoutEX::NoneKoutType);
        return *this << Reset << "[" << type << "] ";
    }

    inline unsigned RegisterType(const char* name, KoutEX::KoutEffect color)
    {
        int re = 0;
        if (RegisteredType < 23) {
            re = ++RegisteredType + 7;
            TypeName[re] = name;
            TypeColor[re] = color;
        }
        return re;
    }

    inline void SwitchTypeOnoff(unsigned char type, bool onoff)
    {
        if (onoff)
            EnabledType |= 1u << type;
        else
            EnabledType &= ~(1u << type);
        SwitchCurrentType(NoneKoutType);
    }

    inline void SetEnabledType(unsigned en)
    {
        EnabledType = en;
        SwitchCurrentType(NoneKoutType);
    }

    inline bool GetTypeOnoff(unsigned char type)
    {
        return EnabledType & 1 << type;
    }

    inline void SetEnableEffect(bool on)
    {
        EnableEffect = on;
    }

    inline KOUT& operator<<(KoutEffect effect)
    {
        if (Precheck() && EnableEffect)
            *this << "\e[" << (int)effect << "m";
        return *this;
    }

    inline KOUT& operator<<(KOUT& (*func)(KOUT&))
    {
        return func(*this);
    }

    inline KOUT& operator<<(const char* s)
    {
        if (Precheck())
            Puts(s);
        return *this;
    }

    inline KOUT& operator<<(char* s)
    {
        return *this << (const char*)s;
    }

    inline KOUT& operator<<(bool b)
    {
        if (Precheck())
            Puts(b ? "true" : "false");
        return *this;
    }

    inline KOUT& operator<<(char ch)
    {
        if (Precheck())
            Putchar(ch);
        return *this;
    }

    inline KOUT& operator<<(unsigned char ch)
    {
        if (Precheck())
            Putchar(ch);
        return *this;
    }

    inline KOUT& operator<<(unsigned long long x)
    {
        if (Precheck()) {
            const int size = 21;
            char buffer[size];
            int len = ullTOpadic(buffer, size, x, 1, 10);
            if (len != -1) {
                buffer[len] = 0;
                Puts(buffer);
            }
        }
        return *this;
    }

    inline KOUT& operator<<(unsigned int x)
    {
        if (Precheck())
            operator<<((unsigned long long)x);
        return *this;
    }

    inline KOUT& operator<<(unsigned short x)
    {
        if (Precheck())
            operator<<((unsigned long long)x);
        return *this;
    }

    inline KOUT& operator<<(unsigned long x)
    {
        if (Precheck())
            operator<<((unsigned long long)x);
        return *this;
    }

    inline KOUT& operator<<(long long x)
    {
        if (Precheck()) {
            if (x < 0) {
                Putchar('-');
                if (x != 0x8000000000000000ull)
                    x = -x;
            }
            operator<<((unsigned long long)x);
        }
        return *this;
    }

    inline KOUT& operator<<(int x)
    {
        if (Precheck())
            operator<<((long long)x);
        return *this;
    }

    inline KOUT& operator<<(short x)
    {
        if (Precheck())
            operator<<((long long)x);
        return *this;
    }

    inline KOUT& operator<<(long x)
    {
        if (Precheck())
            operator<<((long long)x);
        return *this;
    }

    template <typename T>
    KOUT& operator<<(T* p)
    {
        if (Precheck()) {
            Putchar('0');
            Putchar('x');
            const int size = 17; //??
            char buffer[size];
            int len = ullTOpadic(buffer, size, (unsigned long long)p);
            if (len != -1) {
                buffer[len] = 0;
                Puts(buffer);
            }
        }
        return *this;
    }

    template <typename T, typename... Ts>
    KOUT& operator<<(T (*p)(Ts...))
    {
        if (Precheck())
            operator<<((void*)p);
        return *this;
    }

    inline KOUT& operator<<(const DataWithSizeUnited& x)
    {
        if (Precheck()) {
            for (Uint64 s = 0, t = 0; s < x.size; s += x.unitSize, ++t) {
                *this << t << ": ";
                switch (x.flags & 0xFF) {
                case DataWithSizeUnited::F_Hex:
                    for (unsigned long long i = 0; i < x.unitSize && s + i < x.size; ++i) {
                        PrintHex(*((char*)x.data + s + i));
                        Putchar(' ');
                    }
                    break;
                case DataWithSizeUnited::F_Char:
                    for (unsigned long long i = 0; i < x.unitSize && s + i < x.size; ++i)
                        Putchar(*((char*)x.data + s + i));
                    break;
                case DataWithSizeUnited::F_Mixed:
                    for (unsigned long long i = 0; i < x.unitSize && s + i < x.size; Putchar(' '), ++i)
                        if (char ch = *((char*)x.data + s + i); InRange(ch, 32, 126))
                            Putchar(ch);
                        else
                            PrintHex(ch);
                    break;
                }
                Putchar('\n');
            }
        }
        return *this;
    }

    inline KOUT& operator<<(const DataWithSize& x)
    {
        return *this << DataWithSizeUnited(x.data, x.size, x.size);
    }

    template <typename T>
    KOUT& operator<<(const T& x)
    {
        if (Precheck()) {
            Puts("Unknown KOUT type:");
            for (int i = 0; i < sizeof(x); ++i)
                PrintHex(*((char*)&x + i)), Putchar(' ');
        }
        return *this;
    }

protected:
    void PrintFirst(const char* s)
    {
        Puts(s);
    }

    template <typename T>
    void PrintFirst(const char* s, const T& x)
    {
        operator<<(x);
        operator()(s);
    }

    template <typename T, typename... Ts>
    void PrintFirst(const char* s, const T& x, const Ts&... args)
    {
        operator<<(x);
        operator()(s, args...);
    }

public:
    template <typename... Ts>
    KOUT& operator()(const char* s, const Ts&... args)
    {
        if (Precheck())
            while (*s)
                if (*s != '%')
                    Putchar(*s), ++s;
                else if (*(s + 1) == '%')
                    Putchar('%'), s += 2;
                else if (InRange(*(s + 1), 'a', 'z') || InRange(*(s + 1), 'A', 'Z')) {
                    PrintFirst(s + 2, args...);
                    return *this;
                } else
                    Putchar(*s), ++s;
        return *this;
    }

    void Init()
    {
    }
};

extern KOUT kout;

void KernelFaultSolver();

inline KOUT& endl(KOUT& o)
{
    o << "\n"
      << Reset;
    if (o.CurrentType == KoutEX::Fault) {
        o.SwitchCurrentType(KoutEX::NoneKoutType);
        KernelFaultSolver();
    }
    o.SwitchCurrentType(KoutEX::NoneKoutType);
    return o;
}

inline KOUT& endout(KOUT& o)
{
    o << Reset;
    if (o.CurrentType == KoutEX::Fault) {
        o.SwitchCurrentType(KoutEX::NoneKoutType);
        KernelFaultSolver();
    }
    o.SwitchCurrentType(KoutEX::NoneKoutType);
    return o;
}

inline KOUT& endline(KOUT& o)
{
    return o << "\n";
}

inline void KernelFaultSolver() // Remove this if you want to implement it by yourself.
{
    kout << LightRed << "<KernelMonitor>: Kernel fault! Enter infinite loop..." << endline
         << "                 You can add you code in File:\"" << __FILE__ << "\" Line:" << __LINE__ << " to solve fault." << endl;
    SBI_SHUTDOWN();
    while (1)
        ; // Replace your code here, such as shutdown...
}
};

#define ASSERTEX(x, s)                               \
    {                                                \
        if (!(x))                                    \
            POS::kout[POS::Fault] << s << POS::endl; \
    }

using namespace POS; // Remove this if you want to use it by yourself.

// You should add below code in one compile unit if kout is used in multi files.
// namespace POS
//{
//	KOUT kout;
// };

extern unsigned VMMINFO;
extern unsigned NEWINFO;

#endif
