#include <Library/KoutSingle.hpp>

int DebugObjectClass::sum[DebugObjectClass::Total];
int DebugObjectClass::active[DebugObjectClass::Total];
int DebugObjectClass::badfree[DebugObjectClass::Total];
int DebugObjectClass::totalsum=0,
	DebugObjectClass::totalactive=0,
	DebugObjectClass::totalbadfree=0;

extern "C"{
long long memCount;
}