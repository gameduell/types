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
 
package types.haxeinterop;

import haxe.io.BytesData;
import haxe.io.Bytes;
import types.Data;

@:keep
class DataWithHaxeBytes extends Data
{
    private var bytesData : BytesData;

    @:functionCode('
        bytesData = bytes->b;
        _nativeData->setupWithExistingPointer((uint8_t *)bytes->b->GetBase(), bytes->length);
        bytes->b = null();
    ')
    public function setupWithHaxeBytes(bytes: Bytes): Void {}

    override public function trim(): Void
    {
        bytesData = null;
        super.trim();
    }

    override public function resize(newSize: Int): Void
    {
        bytesData = null;
        super.resize(newSize);
    }

}

@:headerCode("
#include <types/NativeData.h>
")

@:access(haxe.io.Bytes)
class DataBytesTools
{
    @:functionCode('
        Array< unsigned char > array = Array_obj< unsigned char >::__new(data->get_offsetLength(), data->get_offsetLength());
		memcpy((void *)array->__CStr(), (char*)data->_nativeData->ptr + data->_nativeData->offset, data->get_offsetLength());
        return ::haxe::io::Bytes_obj::__new(data->get_offsetLength(), array);
	')
    public static function getBytes(data: Data): Bytes {
        return null;

        // protect against DCE
        var dummy = new Bytes(0, null);
    }

    public static function getTypesData(bytes: Bytes): Data
    {
        var d = new DataWithHaxeBytes(0);
        d.setupWithHaxeBytes(bytes);
        return d;
    }

}
