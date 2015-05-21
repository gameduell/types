/*
 * Copyright (c) 2003-2015, GameDuell GmbH
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

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
