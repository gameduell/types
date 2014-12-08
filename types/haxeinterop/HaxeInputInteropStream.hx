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
    private var inputStream: InputStream;
    private var workingData: Data;
    public function new(newInputStream : InputStream)
    {
        #if debug
        if (newInputStream.isAsync())
        {
            throw "HaxeInputInteropStream only works with sync streams";
        }
        #end

        workingData = new Data(8);
        inputStream = newInputStream;
        bigEndian = false;
    }

    override function readByte() : Int
    {
        workingData.offsetLength = 1;
        inputStream.readIntoData(workingData);
        return workingData.readInt(DataTypeUInt8);
    }

    override function readBytes( s : Bytes, pos : Int, len : Int ) : Int 
    {
        workingData.offsetLength = 1;
        for(i in 0...len)
        {
            inputStream.readIntoData(workingData);
            s.set(pos + i, workingData.readInt(DataTypeUInt8));
        }
        return len;
    }

    override function readInt16() 
    {
        workingData.offsetLength = 2;
        inputStream.readIntoData(workingData);
        return workingData.readInt(DataTypeInt16);
    }

    override function readFloat() : Float {
        workingData.offsetLength = 4;
        inputStream.readIntoData(workingData);
        return workingData.readFloat(DataTypeFloat32);
    }

    override function readDouble() : Float {
        workingData.offsetLength = 8;
        inputStream.readIntoData(workingData);
        return workingData.readFloat(DataTypeFloat64);
    }
}