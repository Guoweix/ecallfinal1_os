#ifndef OS16_TYPES_HPP
#define OS16_TYPES_HPP

//该文件定义了若干类型，便于使用和统一修改 
using Sint8=signed char;//此处using相当于C语言的typedef，便于在不同位宽的架构下移植 
using Sint16=signed short;
using Sint32=signed int;
using Sint64=signed long long;
//using Sint128=__int128_t;
using Uint8=unsigned char;
using Uint16=unsigned short;
using Uint32=unsigned int;
using Uint64=unsigned long long;
//using Uint128=__uint128_t;

using RegisterData=Uint64;//与寄存器宽度一致的类型 
using PtrUint=Uint64;//The UintXX of void*
using PtrSint=Sint64;
using ClockTime=Uint64;
using ClockTick=Uint64;
using ErrorType=Sint32;
using PageTableEntryType=Uint64;

using PID=Sint32;
#endif
