#ifndef __TYPES_NATIVE_DATA__
#define __TYPES_NATIVE_DATA__


#include <stdint.h>
	class NativeData
	{
		public: 
			uint8_t * ptr;
			int allocedLength;
			bool externalPtr; /// not alloced here, so not dealloced

			int offset;
			int offsetLength;


			virtual void setup(int lengthInBytes) = 0;

			virtual void setupWithExistingPointer(uint8_t* existingPtr, int lengthInBytes) = 0;
			virtual void cleanUp() = 0;

			virtual void writeData(const NativeData *d) = 0;
			virtual void writePointer(const void* pointer, int lengthInBytes) = 0;

			virtual void resize(int newSize) = 0;

			virtual void trim() = 0;

			static void* createHaxePointer();

			virtual ~NativeData() {};

		protected: 
			NativeData() {} // use types_cpp_createNativeData method
    		NativeData(const NativeData&); // use setup methods instead
    		NativeData& operator=(const NativeData&); // use setup methods instead

	};



#endif //__TYPES_NativeData__