/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 06/06/14
 * Time: 17:10
 */
package types;

import types.DataType.DataTypeUtils;
import types.OutputStream;

using types.DataStringTools;

class DataOutputStream implements OutputStream
{
    private var data : Data;
    private var currentOffset : Int;
    public function new(newData : Data) : Void
    {
        data = newData;
    }

    public function writeData(sourceData : Data) : Void
    {
        var prevOffset = data.offset;
        data.offset = currentOffset;
        data.writeData(sourceData);
        currentOffset += sourceData.offsetLength;
        data.offset = prevOffset;
    }

    public function writeInt(value : Int, targetDataType : DataType) : Void
    {
        var prevOffset = data.offset;
        data.offset = currentOffset;
        data.writeInt(value, targetDataType);
        currentOffset += DataTypeUtils.dataTypeByteSize(targetDataType);
        data.offset = prevOffset;
    }

    public function writeFloat(value : Float, targetDataType : DataType) : Void
    {
        var prevOffset = data.offset;
        data.offset = currentOffset;
        data.writeFloat(value, targetDataType);
        currentOffset += DataTypeUtils.dataTypeByteSize(targetDataType);
        data.offset = prevOffset;
    }

    public function writeIntArray(array : Array<Int>, dataType : DataType) : Void
    {
        for(i in 0...array.length)
        {
            writeInt(array[i], dataType);
        }
    }

    public function writeFloatArray(array : Array<Float>, dataType : DataType) : Void
    {
        for(i in 0...array.length)
        {
            writeFloat(array[i], dataType);
        }
    }

    public function writeString(string : String) : Void
    {
        var prevOffset = data.offset;
        data.offset = currentOffset;
        data.writeString(string);
        data.offset = prevOffset;
        currentOffset += string.sizeInBytes();
    }

    public function available() : Bool
    {
        return currentOffset < data.offset + data.offsetLength;
    }

    public function close() : Void
    {
        data = null;
    }
}