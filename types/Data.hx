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
            byteArray.position = 0;
            byteArray.length = sizeInBytes;
        }
    }


    public function set_byteArray(value : ByteArray) : ByteArray
    {
        byteArray = value;
        _offsetLength = byteArray.length;

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
            case DataTypeByte:
                returnValue =  byteArray.readByte();
            case DataTypeUnsignedByte:
                returnValue =  cast byteArray.readUnsignedByte();
            case DataTypeShort:
                returnValue =  byteArray.readShort();
            case DataTypeUnsignedShort:
                returnValue =  cast byteArray.readUnsignedShort();
            case DataTypeInt:
                returnValue =  byteArray.readInt();
            case DataTypeUnsignedInt:
                returnValue =  cast byteArray.readUnsignedInt();
            case DataTypeFloat:
                returnValue =  Std.int(byteArray.readFloat());
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
            case DataTypeByte:
                returnValue =  byteArray.readByte();
            case DataTypeUnsignedByte:
                returnValue =  cast byteArray.readUnsignedByte();
            case DataTypeShort:
                returnValue =  byteArray.readShort();
            case DataTypeUnsignedShort:
                returnValue =  cast byteArray.readUnsignedShort();
            case DataTypeInt:
                returnValue =  byteArray.readInt();
            case DataTypeUnsignedInt:
                returnValue =  cast byteArray.readUnsignedInt();
            case DataTypeFloat:
                returnValue = byteArray.readFloat();
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

            byteArray.position = i * dataSize;
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
            byteArray.position = i * dataSize;
            writeFloat(array[i], dataType);

        }
        offset = prevOffset;
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
        offset = prevOffset;
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
        newBuffer.writeBytes(byteArray, 0, newSize);
        newBuffer.position = prevPosition;
        set_byteArray(newBuffer);
    }


}