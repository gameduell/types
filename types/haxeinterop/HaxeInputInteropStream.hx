/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 06/06/14
 * Time: 20:09
 */
package types.haxeinterop;

import haxe.io.Eof;
import haxe.io.Bytes;
import haxe.io.Input;

using types.haxeinterop.DataBytesTools;

class HaxeInputInteropStream extends Input
{
    private var inputStream : InputStream;
    public function new(newInputStream : InputStream)
    {
        inputStream = newInputStream;
        bigEndian = false;
    }

    override function readByte() : Int
    {
        return inputStream.readInt(DataTypeUInt8);
    }

    override function readBytes( s : Bytes, pos : Int, len : Int ) : Int {
        for(i in 0...len)
        {
            s.set(pos + i, inputStream.readInt(DataTypeUInt8));
        }
        return len;
    }

    override function readInt16() {

        return inputStream.readInt(DataTypeInt16);
    }

    override function readFloat() : Float {
        return inputStream.readFloat(DataTypeFloat32);
    }

    override function readDouble() : Float {
        return inputStream.readFloat(DataTypeFloat64);
    }
}