#ifndef __TYPES_POINTER__
#define __TYPES_POINTER__

#include <memory>

namespace types
{
	struct NullPointerDeleter { void operator()(void const *) const {} };
	struct _Pointer
	{
		std::shared_ptr<uint8_t > ptr;
		int allocedLength;

		int offset;
		int offsetLength;

		_Pointer() {}

		_Pointer(int lengthInBytes) : 	ptr((uint8_t *)calloc(lengthInBytes, 1)),
										allocedLength(lengthInBytes),
										offset(0),
										offsetLength(lengthInBytes)
		{

		}

		_Pointer(uint8_t* existingPointer, int lengthInBytes) : ptr(existingPointer, NullPointerDeleter()),
																allocedLength(-1),
																offset(0),
																offsetLength(lengthInBytes)
		{

		}

		void writeDataFromPointer(const _Pointer &p)
		{
			memcpy(ptr.get() + offset, p.ptr.get() + p.offset, p.offsetLength);
		}
	};

	typedef struct _Pointer Pointer;

}

#endif //__TYPES_POINTER__