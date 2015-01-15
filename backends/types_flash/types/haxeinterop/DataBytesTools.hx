/*
 * Created by IntelliJ IDEA.
 * User: epai
 * Date: 15/06/14
 * Time: 14:00
 */
package types.haxeinterop;

import haxe.io.Bytes;

@:access(types.Data)
@:access(haxe.io.Bytes)
class DataBytesTools
{
    ///creates a copy, use with care for performance
    public static function getBytes(data : Data) : Bytes
    {
        data.setByteArrayPositionLazily();
        return new Bytes(data.offsetLength, data.byteArray);
    }

    public static function getTypesData(bytes : Bytes) : Data
    {
    	var d = new Data(0);

    	d.byteArray = bytes.getData();

    	return d;
    }
}