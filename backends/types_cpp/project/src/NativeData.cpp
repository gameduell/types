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
		void writePointer(const void* pointer, int lengthInBytes);

		void resize(int newSize);
		void trim();

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
	externalPtr = false;
}

void NativeData_Impl::setupWithExistingPointer(uint8_t* existingPtr, int lengthInBytes)
{
	cleanUp();
	ptr = existingPtr;
	allocedLength = lengthInBytes;

	offset = 0;
	offsetLength = lengthInBytes;
	externalPtr = true;
}

void NativeData_Impl::cleanUp()
{
	if(allocedLength > 0 && !externalPtr)
		free(ptr);

	ptr = 0;
	allocedLength = 0;
	offset = 0;
	offsetLength = 0;
	externalPtr = false;
}

NativeData_Impl::NativeData_Impl()
{
	ptr = 0;
	allocedLength = 0;
	offset = 0;
	offsetLength = 0;
	externalPtr = false;
}

void NativeData_Impl::writeData(const NativeData *d)
{
	memcpy(ptr + offset, d->ptr + d->offset, d->offsetLength);
}

void NativeData_Impl::writePointer(const void* pointer, int lengthInBytes)
{
	memcpy(ptr + offset, pointer, lengthInBytes);
}

void NativeData_Impl::resize(int newSize)
{
	if(externalPtr)
	{
		uint8_t* prevPtr = ptr;
		ptr = (uint8_t*)calloc(newSize, 1);
		if (newSize > allocedLength)
		{
			memcpy(ptr, prevPtr, allocedLength);
		}
		else
		{
			memcpy(ptr, prevPtr, newSize);
		}
		externalPtr = false;
	}
	else
	{
	    if (newSize == 0)
	    {
	        cleanUp();
	    }
	    else
	    {
	        ptr = (uint8_t*)realloc(ptr, newSize);
            int extraSizeToZeroOut = newSize - allocedLength;
            if(extraSizeToZeroOut > 0)
            {
                memset(ptr + allocedLength, 0, extraSizeToZeroOut);
            }
	    }
	}

	allocedLength = newSize;
}

void NativeData_Impl::trim()
{
	uint8_t* prevPtr = ptr;
	ptr = (uint8_t*)calloc(offsetLength, 1);
	memcpy(ptr, prevPtr + offset, offsetLength);

	if (externalPtr)
	{
		externalPtr = false;
	}
	else
	{
		free(prevPtr);
	}

	allocedLength = offsetLength;
	offset = 0;
}

NativeData_Impl::~NativeData_Impl()
{
	cleanUp();
}

static void finalizer(value abstract_object)
{
     NativeData_Impl* data = (NativeData_Impl *)val_data(abstract_object);
     data->cleanUp();
     delete data;
}

DEFINE_KIND(k_NativeData)

void* NativeData::createHaxePointer()
{
	value v;
	v = alloc_abstract(k_NativeData, new NativeData_Impl());
	val_gc(v, (hxFinalizer) &finalizer);
	return (void*)v;
}
