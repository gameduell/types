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
    private var workingData: Data;
    public function new(newOutputStream : OutputStream)
    {
        #if debug
        if (newOutputStream.isAsync())
        {
            throw "HaxeOutputInteropStream only works with sync streams";
        }
        #end
        workingData = new Data(8);
        outputStream = newOutputStream;
        bigEndian = false;
    }

    override function writeByte( c : Int ) : Void
    {
        workingData.offsetLength = 1;
        workingData.writeInt(c, DataTypeUInt8);
        outputStream.writeData(workingData);
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