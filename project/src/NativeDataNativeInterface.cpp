

#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif
#include <hx/CFFI.h>

#include <types/NativeData.h>

DEFINE_KIND(k_NativeData) 

extern NativeData * createNativeData();

static value nativedata_createNativeData() 
{
	return alloc_abstract(k_NativeData, createNativeData());
}
DEFINE_PRIM (nativedata_createNativeData, 0);


extern "C" int nativedata_register_prims () { return 0; }