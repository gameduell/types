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
        return inputStream.readInt(DataTypeByte);
    }

    override function readBytes( s : Bytes, pos : Int, len : Int ) : Int {
        for(i in 0...len)
        {
            s.set(pos + i, inputStream.readInt(DataTypeUnsignedByte));
        }
        return len;
    }


    override function readInt16() {
        var ch1 = readByte();
        var ch2 = readByte();

        var n = bigEndian ? ch2 | (ch1 << 8) : ch1 | (ch2 << 8);

        /// For some reason this if breaks things on the superclass
        //if( n & 0x8000 != 0 )
        //     return n - 0x10000;
        return n;
    }


    override function readInt24() {
        var ch1 = readByte();
        var ch2 = readByte();
        var ch3 = readByte();

        var n = bigEndian ? ch3 | (ch2 << 8) | (ch1 << 16) : ch1 | (ch2 << 8) | (ch3 << 16);

        /// For some reason this if breaks things on the superclass
        //if( n & 0x800000 != 0 )
        //    return n - 0x1000000;
        return n;
    }

    override function readFloat() : Float {
        return inputStream.readFloat(DataTypeFloat);
    }

    override function readDouble() : Float {
        return inputStream.readFloat(DataTypeDouble);
    }
}