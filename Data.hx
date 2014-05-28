package types;
import Float;
import flash.utils.ByteArray;
import DataType;

class Data
{
    private var _offsetLength : Int;

    public function get_allocedLength() : Int
    {
        return byteArray.length;
    }

    public var offset(get, set) : Int;

    public function set_offset(value : Int) : Int
    {
        byteArray.position = value;
        return byteArray.position;
    }

    public function get_offset() : Int
    {
        return byteArray.position;
    }

    public var offsetLength(get, set) : Int;

    public function set_offsetLength(value : Int) : Int
    {
        _offsetLength = value;
        return _offsetLength;
    }

    public function get_offsetLength() : Int
    {
        return _offsetLength;
    }

    public function resetOffset() : Void
    {
        byteArray.position = 0;
        _offsetLength = byteArray.length;
    }


    public var byteArray(default, set) : ByteArray;


    public function new(sizeInBytes : Int) : Void
    {
        if(sizeInBytes != 0)
        {
            _offsetLength = sizeInBytes;
            byteArray.position = 0;
            byteArray = new ByteArray();
            byteArray.length = sizeInBytes;
        }
    }


    public function set_byteArray(value : ByteArray) : ByteArray
    {
        byteArray = value;
        _offsetLength = byteArray.length;
        byteArray.position = 0;

        return value;
    }

    public function writeData(data : Data) : Void
    {
        byteArray.writeBytes(data.byteArray, data.offset, data.byteArray.length);
    }

    public function readInt(targetDataType : DataType) : Int
    {
        switch(targetDataType)
        {
            case DataTypeByte:
                return byteArray.readByte();
            case DataTypeUnsignedByte:
                return byteArray.readUnsignedByte().toInt();
            case DataTypeShort:
                return byteArray.readShort();
            case DataTypeUnsignedShort:
                return byteArray.readUnsignedShort().toInt();
            case DataTypeInt:
                return byteArray.readInt();
            case DataTypeUnsignedInt:
                return byteArray.readUnsignedInt().toInt();
            case DataTypeFloat:
                return Std.int(byteArray.readFloat());
        }
        return 0;
    }

    public function readFloat(targetDataType : DataType) : Float
    {
        switch(targetDataType)
        {
            case DataTypeByte:
                return byteArray.readByte();
            case DataTypeUnsignedByte:
                return byteArray.readUnsignedByte().toFloat();
            case DataTypeShort:
                return byteArray.readShort();
            case DataTypeUnsignedShort:
                return byteArray.readUnsignedShort().toFloat();
            case DataTypeInt:
                return byteArray.readInt();
            case DataTypeUnsignedInt:
                return byteArray.readUnsignedInt().toFloat();
            case DataTypeFloat:
                return byteArray.readFloat();
        }
        return 0;
    }


    public function writeIntArray(array : Array<Int>, dataType : DataType) : Void
    {
        var dataSize = types.DataTypeUtils.dataTypeByteSize(dataType);

        var prevOffset = byteArray.position;
        for(i in 0...array.length)
        {
            writeInt(array[i], dataType);
        }
        byteArray.position = prevOffset;
    }

    public function writeFloatArray(array : Array<Float>, dataType : DataType) : Void
    {
        var dataSize = types.DataTypeUtils.dataTypeByteSize(dataType);

        var prevOffset = byteArray.position;
        for(i in 0...array.length)
        {
            writeFloat(array[i], dataType);
        }
        byteArray.position = prevOffset;
    }

    public function writeInt(value : Int, targetDataType : DataType) : Void
    {
        switch(targetDataType)
        {
            case DataTypeByte:
                byteArray.writeByte(value);
                return;
            case DataTypeUnsignedByte:
                byteArray.writeByte(value);
                return;
            case DataTypeShort:
                byteArray.writeShort(value);
                return;
            case DataTypeUnsignedShort:
                byteArray.writeShort(value);
                return;
            case DataTypeInt:
                byteArray.writeInt(value);
                return;
            case DataTypeUnsignedInt:
                byteArray.writeUnsignedInt(value);
                return;
            case DataTypeFloat:
                byteArray.writeFloat(value);
                return;
        }
        return;
    }

    public function writeFloat(value : Float, targetDataType : DataType) : Void
    {
        switch(targetDataType)
        {
            case DataTypeByte:
                byteArray.writeByte(Std.int(value));
                return;
            case DataTypeUnsignedByte:
                byteArray.writeByte(Std.int(value));
                return;
            case DataTypeShort:
                byteArray.writeShort(Std.int(value));
                return;
            case DataTypeUnsignedShort:
                byteArray.writeShort(Std.int(value));
                return;
            case DataTypeInt:
                byteArray.writeInt(Std.int(value));
                return;
            case DataTypeUnsignedInt:
                byteArray.writeUnsignedInt(Std.int(value));
                return;
            case DataTypeFloat:
                byteArray.writeFloat(value);
                return;
        }
        return;
    }

    public function toString(?dataType : DataType) : String
    {
        byteArray.position = 0;
        return byteArray.readUTFBytes(byteArray.length);
    }

    public function resize(newSize : Int) : Void
    {
        var newBuffer:ByteArray = new ByteArray();
        newBuffer.length = newSize;
        newBuffer.writeBytes(byteArray, 0, newSize);
        set_byteArray(newBuffer);
    }


}