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
        offset = 0;
        _offsetLength = byteArray.length;
    }


    public var byteArray(default, set) : ByteArray;


    public function new(sizeInBytes : Int) : Void
    {
        if(sizeInBytes != 0)
        {
            _offsetLength = sizeInBytes;
            byteArray = new ByteArray();
            byteArray.length = sizeInBytes;
            byteArray.position = 0;
        }
    }


    public function set_byteArray(value : ByteArray) : ByteArray
    {
        byteArray = value;
        return value;
    }

    public function writeData(data : Data) : Void
    {
        var prevOffset = byteArray.position;
        byteArray.writeBytes(data.byteArray, data.offset, data.byteArray.length);
        offset = prevOffset;
    }

    public function readInt(targetDataType : DataType) : Int
    {
        var prevOffset = byteArray.position;
        var returnValue = 0;
        switch(targetDataType)
        {
            case DataTypeInt8:
                return byteArray.readByte();
            case DataTypeUInt8:
                return cast byteArray.readUnsignedByte();
            case DataTypeInt16:
                return byteArray.readShort();
            case DataTypeUInt16:
                return cast byteArray.readUnsignedShort();
            case DataTypeInt32:
                return byteArray.readInt();
            case DataTypeUInt32:
                return cast byteArray.readUnsignedInt();
            case DataTypeFloat32:
                return Std.int(byteArray.readFloat());
            case DataTypeFloat64:
                return Std.int(byteArray.readDouble());
        }
        offset = prevOffset;
        return returnValue;
    }

    public function readFloat(targetDataType : DataType) : Float
    {
        var prevOffset = byteArray.position;
        var returnValue = 0.0;
        switch(targetDataType)
        {
            case DataTypeInt8:
                return byteArray.readByte();
            case DataTypeUInt8:
                return cast byteArray.readUnsignedByte();
            case DataTypeInt16:
                return byteArray.readShort();
            case DataTypeUInt16:
                return cast byteArray.readUnsignedShort();
            case DataTypeInt32:
                return byteArray.readInt();
            case DataTypeUInt32:
                return cast byteArray.readUnsignedInt();
            case DataTypeFloat32:
                return byteArray.readFloat();
            case DataTypeFloat64:
                return byteArray.readDouble();
        }
        offset = prevOffset;
        return returnValue;
    }


    public function writeIntArray(array : Array<Int>, dataType : DataType) : Void
    {
        var dataSize = types.DataTypeUtils.dataTypeByteSize(dataType);

        var prevOffset = byteArray.position;
        for(i in 0...array.length)
        {
            byteArray.position = prevOffset + (i * dataSize);
            writeInt(array[i], dataType);
        }
        offset = prevOffset;
    }

    public function writeFloatArray(array : Array<Float>, dataType : DataType) : Void
    {
        var dataSize = types.DataTypeUtils.dataTypeByteSize(dataType);

        var prevOffset = byteArray.position;
        for(i in 0...array.length)
        {
            byteArray.position = prevOffset + (i * dataSize);
            writeFloat(array[i], dataType);

        }
        offset = prevOffset;
    }

    public function writeInt(value : Int, targetDataType : DataType) : Void
    {
        var prevOffset = byteArray.position;
        switch(targetDataType)
        {
            case DataTypeInt8:
                byteArray.writeByte(value);
                
            case DataTypeUInt8:
                byteArray.writeByte(value);

            case DataTypeInt16:
                byteArray.writeShort(value);

            case DataTypeUInt16:
                byteArray.writeShort(value);

            case DataTypeInt32:
                byteArray.writeInt(value);

            case DataTypeUInt32:
                byteArray.writeUnsignedInt(value);

            case DataTypeFloat32:
                byteArray.writeFloat(value);

            case DataTypeFloat64:
                byteArray.writeDouble(value);
        }
        offset = prevOffset;
        return;
    }

    public function writeFloat(value : Float, targetDataType : DataType) : Void
    {
        var prevOffset = byteArray.position;
        switch(targetDataType)
        {
            case DataTypeInt8:
                byteArray.writeByte(Std.int(value));

            case DataTypeUInt8:
                byteArray.writeByte(Std.int(value));

            case DataTypeInt16:
                byteArray.writeShort(Std.int(value));

            case DataTypeUInt16:
                byteArray.writeShort(Std.int(value));

            case DataTypeInt32:
                byteArray.writeInt(Std.int(value));

            case DataTypeUInt32:
                byteArray.writeUnsignedInt(Std.int(value));

            case DataTypeFloat32:
                byteArray.writeFloat(value);

            case DataTypeFloat64:
                byteArray.writeDouble(value);
        }
        offset = prevOffset;
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

        var func: types.DataType -> Float;

        if(dataType == DataTypeFloat){
            func = readFloat;
        }else{
            func = readInt;
        }

        var returnString:String = "";
        while (byteArray.bytesAvailable >0) {

            var nextPosition : Int = byteArray.position + dataTypeSize;

            returnString += func(dataType);
            byteArray.position = nextPosition;

            if(byteArray.bytesAvailable>0)returnString += ",";

        }

        offset = prevPosition;
        return returnString;
    }

    public function resize(newSize : Int) : Void
    {
        var prevPosition : Int = byteArray.position;
        var newBuffer:ByteArray = new ByteArray();
        newBuffer.length = newSize;
        newBuffer.writeBytes(byteArray, 0, byteArray.length);
        newBuffer.position = prevPosition;
        _offsetLength = newSize;
        set_byteArray(newBuffer);
    }


}