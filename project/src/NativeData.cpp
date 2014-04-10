#include <types/NativeData.h>
#include <string>

#include <hx/CFFI.h>


class NativeData_Impl : public NativeData
{
	public:
		void setup(int lengthInBytes);

		void setupWithExistingPointer(uint8_t* existingPtr, int lengthInBytes);
		void cleanUp();

		void writeData(const NativeData *d);

		~NativeData_Impl();
		NativeData_Impl();
};

void NativeData_Impl::setup(int lengthInBytes)
{
	cleanUp();
	ptr = (uint8_t *)calloc(lengthInBytes, 1);
	allocedLength = lengthInBytes;

	offset = 0;
	offsetLength = lengthInBytes;
}

void NativeData_Impl::setupWithExistingPointer(uint8_t* existingPtr, int lengthInBytes)
{
	cleanUp();
	ptr = existingPtr;
	allocedLength = -1;	

	offset = 0;
	offsetLength = lengthInBytes;
}

void NativeData_Impl::cleanUp()
{
	if(allocedLength > 0)
		free(ptr);

	ptr = 0;
	allocedLength = 0;
	offset = 0;
	offsetLength = 0;
}

NativeData_Impl::NativeData_Impl()
{
	ptr = 0;
	allocedLength = 0;
	offset = 0;
	offsetLength = 0;
}


NativeData_Impl::~NativeData_Impl()
{
	cleanUp();
}

void NativeData_Impl::writeData(const NativeData *d)
{
	memcpy(ptr + offset, d->ptr + d->offset, d->offsetLength);
}

NativeData* createNativeData()
{
	return new NativeData_Impl();
}


