/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 06/06/14
 * Time: 20:21
 */
package types.haxeinterop;

import haxe.io.BytesData;
import haxe.io.Bytes;
import types.Data;

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
    public static function getBytes(data: Data): Bytes { return null; }

    public static function getTypesData(bytes: Bytes): Data
    { 
        var d = new DataWithHaxeBytes(0);
        d.setupWithHaxeBytes(bytes);
        return d; 
    }

}