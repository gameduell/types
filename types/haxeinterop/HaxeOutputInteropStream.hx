/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 10/06/14
 * Time: 11:57
 */
package types.haxeinterop;
import haxe.io.Eof;
import haxe.io.Input;
import haxe.io.Bytes;
import haxe.io.Output;
import haxe.io.Error;
class HaxeOutputInteropStream extends Output
{
    private var outputStream : OutputStream;
    public function new(newOutputStream : OutputStream)
    {
        outputStream = newOutputStream;
        bigEndian = false;
    }

    override function writeByte( c : Int ) : Void
    {
        outputStream.writeInt(c, DataTypeUInt8);
    }

    override function writeBytes( s : Bytes, pos : Int, len : Int ) : Int
    {
        for(i in 0...len)
        {
            writeByte(s.get(pos + i));
        }
        return len;
    }

    override function flush()
    {

    }

    override function close()
    {
        outputStream.close();
    }

}