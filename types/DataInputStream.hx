/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 06/06/14
 * Time: 17:10
 */
package types;

import types.DataType.DataTypeUtils;
import types.InputStream;

using types.DataStringTools;

class DataInputStream implements InputStream
{
    private var data : Data;
    private var currentOffset : Int;

    public function new(newData : Data) : Void
    {
        data = newData;
        currentOffset = data.offset;
    }

    public function readInt(targetDataType : DataType) : Int
    {
        var prevOffset = data.offset;
        data.offset = currentOffset;
        var v = data.readInt(targetDataType);
        currentOffset += DataTypeUtils.dataTypeByteSize(targetDataType);
        data.offset = prevOffset;
        return v;
    }

    public function readFloat(targetDataType : DataType) : Float
    {
        var prevOffset = data.offset;
        data.offset = currentOffset;
        var v = data.readFloat(targetDataType);
        currentOffset += DataTypeUtils.dataTypeByteSize(targetDataType);
        data.offset = prevOffset;
        return v;
    }


    public function readIntArray(count : Int, targetDataType) : Array<Int>
    {
        var array = new Array<Int>();
        for(i in 0...count)
        {
            array.push(readInt(targetDataType));
        }
        return array;
    }

    public function readFloatArray(count : Int, targetDataType) : Array<Float>
    {
        var array = new Array<Float>();
        for(i in 0...count)
        {
            array.push(readFloat(targetDataType));
        }
        return array;
    }

    public function readString(byteCount : Int) : String
    {
        var prevOffset = data.offset;
        var prevOffsetLength = data.offsetLength;
        data.offset = currentOffset;
        data.offsetLength = byteCount;
        var v = data.readString();
        currentOffset += byteCount;
        data.offset = prevOffset;
        data.offsetLength = prevOffsetLength;
        return v;
    }

    public function readIntoData(receivingData : Data) : Void
    {
        var prevOffset = data.offset;
        data.offset = currentOffset;
        receivingData.writeData(data);
        currentOffset += receivingData.offsetLength;
        data.offset = prevOffset;
    }

    public function available() : Bool
    {
        return currentOffset < data.offset + data.offsetLength;
    }

    public function skip(count : Int) : Void
    {
        currentOffset += count;
    }

    public function close() : Void
    {
        data = null;
    }
}