/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 06/06/14
 * Time: 20:17
 */
package types.haxeinterop;

import haxe.io.Bytes;

extern class DataBytesTools
{
    ///creates a copy, use with care for performance
    public static function getBytes(data : Data) : Bytes;
}