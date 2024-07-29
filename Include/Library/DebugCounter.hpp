#ifndef __DEBUGCOUNTER_HPP
#define __DEBUGCOUNTER_HPP

// #include "Library/KoutSingle.hpp"
#include "Library/KoutSingle.hpp"
#define xout kout

extern "C" 
{
extern long long memCount;
}

class DebugObjectClass
{
	public:
		enum
		{
			UnknownName=0,
            FileNode,
            file_object,
            ext4node,
            EXT4,
            DISK,
			Total,
		};
		static const char* GetClassNames(int id)
		{
			static const char* ClassNames[]=
			{

			"UnknownName",
            "FileNode",
            "file_object",
            "ext4node",
            "EXT4",
            "DISK",
			"Total",
			};
			ASSERTEX(sizeof(ClassNames)/sizeof(const char*)==Total+1,"enum count error");
			return ClassNames[id];
		}
	
	protected:
		static int sum[Total];
		static int active[Total];
		static int badfree[Total];
		static int totalsum,
				   totalactive,
				   totalbadfree;
		
		int ID=0;
		bool freed=false;
		
		void Con()
		{
			sum[ID]++;
			active[ID]++;
			totalsum++;
			totalactive++;
		}
		
		void Decon()
		{
			active[ID]--;
			totalactive--;
			if (freed)
			{
				badfree[ID]++;
				totalbadfree++;
			}
			freed=true;
		}
		
	public:
		
		DebugObjectClass(DebugObjectClass&&)=delete;
		
		DebugObjectClass(const DebugObjectClass &tar)
		{
			ID=tar.ID;
			Con();
		}
		
		~DebugObjectClass()
		{
			Decon();
		}
		
		DebugObjectClass(int id):ID(id)
		{
			Con();
		}
		
		static void Print()
		{
			xout[Test]<<"DebugObject_Class counter:"<<endline;
			xout<<Green<<"sum of classes:"<<endline<<LightCyan;
			for (int i=0;i<Total;++i)
				xout<<i<<"-"<<GetClassNames(i)<<": "<<sum[i]<<endline;
			xout<<Green<<"active of classes:"<<endline<<LightCyan;
			for (int i=0;i<Total;++i)
				xout<<i<<"-"<<GetClassNames(i)<<": "<<active[i]<<endline;
			xout<<Green<<"badfree of classes:"<<endline<<LightCyan;
			for (int i=0;i<Total;++i)
				xout<<i<<"-"<<GetClassNames(i)<<": "<<badfree[i]<<endline;
			xout<<Green;
			xout<<"Total sum    : "<<totalsum<<endline
				<<"Total active : "<<totalactive<<endline
				<<"Total badfree: "<<totalbadfree<<endline
				<<"Memory Count:  "<<memCount<<endline
				<<endl;
		}
};

#define DEBUG_CLASS_HEADER(x) 				\
	private:								\
		DebugObjectClass __DebugClassObj{DebugObjectClass::x};	\
	public:
#undef xout

#endif
