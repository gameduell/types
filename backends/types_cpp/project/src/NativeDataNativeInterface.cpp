

#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif
#include <hx/CFFI.h>

#include <types/NativeData.h>


extern NativeData * createNativeData();

static value nativedata_createNativeData() 
{
	return NativeData::createHaxePointer();
}
DEFINE_PRIM (nativedata_createNativeData, 0);


extern "C" int nativedata_register_prims () { return 0; }