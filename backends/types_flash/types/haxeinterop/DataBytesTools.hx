/*
 * Created by IntelliJ IDEA.
 * User: epai
 * Date: 15/06/14
 * Time: 14:00
 */
package types.haxeinterop;

import haxe.io.Bytes;

extern class DataBytesTools
{
    ///creates a copy, use with care for performance
    public static function getBytes(data : Data) : Bytes{
        return new Bytes(data.offsetLength, data.byteArray);
    }
}