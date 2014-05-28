package types;
import flash.utils.ByteArray;
import types.DataType;

class Data
{
    private var _offsetLength : Int;

    public var allocedLength(get, null) : Int;

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
            byteArray = new ByteArray();
            byteArray.position = 0;
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
        var prevOffset = byteArray.position;
        byteArray.writeBytes(data.byteArray, data.offset, data.byteArray.length);
        byteArray.position = prevOffset;
    }

    public function readInt(targetDataType : DataType) : Int
    {
        var prevOffset = byteArray.position;
        switch(targetDataType)
        {
            case DataTypeByte:
                return byteArray.readByte();
            case DataTypeUnsignedByte:
                return cast byteArray.readUnsignedByte();
            case DataTypeShort:
                return byteArray.readShort();
            case DataTypeUnsignedShort:
                return cast byteArray.readUnsignedShort();
            case DataTypeInt:
                return byteArray.readInt();
            case DataTypeUnsignedInt:
                return cast byteArray.readUnsignedInt();
            case DataTypeFloat:
                return Std.int(byteArray.readFloat());
        }
        byteArray.position = prevOffset;
        return 0;
    }

    public function readFloat(targetDataType : DataType) : Float
    {
        var prevOffset = byteArray.position;
        switch(targetDataType)
        {
            case DataTypeByte:
                return byteArray.readByte();
            case DataTypeUnsignedByte:
                return cast byteArray.readUnsignedByte();
            case DataTypeShort:
                return byteArray.readShort();
            case DataTypeUnsignedShort:
                return cast byteArray.readUnsignedShort();
            case DataTypeInt:
                return byteArray.readInt();
            case DataTypeUnsignedInt:
                return cast byteArray.readUnsignedInt();
            case DataTypeFloat:
                return byteArray.readFloat();
        }
        byteArray.position = prevOffset;
        return 0;
    }


    public function writeIntArray(array : Array<Int>, dataType : DataType) : Void
    {
        var dataSize = types.DataTypeUtils.dataTypeByteSize(dataType);

        var prevOffset = byteArray.position;
        for(i in 0...array.length)
        {
            var nextOffset = byteArray.position + dataSize;

            writeInt(array[i], dataType);

            byteArray.position = nextOffset;
        }
        byteArray.position = prevOffset;
    }

    public function writeFloatArray(array : Array<Float>, dataType : DataType) : Void
    {
        var dataSize = types.DataTypeUtils.dataTypeByteSize(dataType);

        var prevOffset = byteArray.position;
        for(i in 0...array.length)
        {
            var nextOffset = byteArray.position + dataSize;

            writeFloat(array[i], dataType);

            byteArray.position = nextOffset;
        }
        byteArray.position = prevOffset;
    }

    public function writeInt(value : Int, targetDataType : DataType) : Void
    {
        var prevOffset = byteArray.position;
        switch(targetDataType)
        {
            case DataTypeByte:
                byteArray.writeByte(value);
                
            case DataTypeUnsignedByte:
                byteArray.writeByte(value);

            case DataTypeShort:
                byteArray.writeShort(value);

            case DataTypeUnsignedShort:
                byteArray.writeShort(value);

            case DataTypeInt:
                byteArray.writeInt(value);

            case DataTypeUnsignedInt:
                byteArray.writeUnsignedInt(value);

            case DataTypeFloat:
                byteArray.writeFloat(value);
        }
        byteArray.position = prevOffset;
        return;
    }

    public function writeFloat(value : Float, targetDataType : DataType) : Void
    {
        var prevOffset = byteArray.position;
        switch(targetDataType)
        {
            case DataTypeByte:
                byteArray.writeByte(Std.int(value));

            case DataTypeUnsignedByte:
                byteArray.writeByte(Std.int(value));

            case DataTypeShort:
                byteArray.writeShort(Std.int(value));

            case DataTypeUnsignedShort:
                byteArray.writeShort(Std.int(value));

            case DataTypeInt:
                byteArray.writeInt(Std.int(value));

            case DataTypeUnsignedInt:
                byteArray.writeUnsignedInt(Std.int(value));

            case DataTypeFloat:
                byteArray.writeFloat(value);
        }
        byteArray.position = prevOffset;
        return;
    }

    public function toString(?dataType : DataType = null) : String
    {
        if(dataType == null)
        {
            dataType = DataTypeInt;
        }

        var dataTypeSize : Int = DataTypeUtils.dataTypeByteSize(dataType);

        var prevPosition : Int = byteArray.position;
        byteArray.position = 0;

        var returnString:String ="";

        while (byteArray.bytesAvailable >0) {

            var nextPosition : Int = byteArray.position + dataTypeSize;

            returnString += readInt(dataType) + ",";

            byteArray.position = nextPosition;
        }

        return returnString;
    }

    public function resize(newSize : Int) : Void
    {
        var newBuffer:ByteArray = new ByteArray();
        newBuffer.length = newSize;
        newBuffer.writeBytes(byteArray, 0, newSize);
        set_byteArray(newBuffer);
    }


}