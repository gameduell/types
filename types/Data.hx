package types;
import flash.utils.Endian;
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
            byteArray.endian = Endian.LITTLE_ENDIAN;
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
        byteArray.writeBytes(data.byteArray, 0, data.byteArray.length);
        byteArray.position = prevOffset;
    }

    public function readIntArray(length:Int, targetDataType : DataType) : Array<Int>
    {
        var dataSize = types.DataTypeUtils.dataTypeByteSize(targetDataType);
        var prevOffset = byteArray.position;
        var returnArray = new Array<Int>();

        for(i in 0...length)
        {
            byteArray.position = prevOffset + (i * dataSize);
            returnArray.push(readInt(targetDataType));
        }

        byteArray.position = prevOffset;

        return returnArray;
    }

    public function readUIntArray(targetDataType : DataType) : Array<UInt>
    {
        var dataSize = types.DataTypeUtils.dataTypeByteSize(targetDataType);
        var returnArray = new Array<UInt>();
        var prevOffset = byteArray.position;
        var length:Int  = cast byteArray.length / dataSize;

        for(i in 0...length)
        {
            byteArray.position = prevOffset + (i * dataSize);
            returnArray.push(readInt(targetDataType));
        }

        byteArray.position = prevOffset;

        return returnArray;
    }

    public function readFloatArray(targetDataType : DataType) : Array<Float>
    {
        var dataSize = types.DataTypeUtils.dataTypeByteSize(targetDataType);
        var prevOffset = byteArray.position;
        var returnArray = new Array<Float>();
        var length:Int  = cast byteArray.length / dataSize;

        for(i in 0...length)
        {
            byteArray.position = prevOffset + (i * dataSize);
            returnArray.push(readFloat(targetDataType));
        }

        byteArray.position = prevOffset;

        return returnArray;
    }

    public function readInt(targetDataType : DataType) : Int
    {
        var prevOffset = byteArray.position;
        var returnValue:Int;

        switch(targetDataType)
        {
            case DataTypeInt8:
                returnValue =  byteArray.readByte();

            case DataTypeUInt8:
                returnValue =  byteArray.readUnsignedByte();

            case DataTypeInt16:
                returnValue =  byteArray.readShort();

            case DataTypeUInt16:
                returnValue =  byteArray.readUnsignedShort();

            case DataTypeInt32:
                returnValue =  byteArray.readInt();

            case DataTypeUInt32:
                returnValue = byteArray.readUnsignedInt();

            case DataTypeFloat32:
                returnValue =  Std.int(byteArray.readFloat());

            case DataTypeFloat64:
                returnValue =  Std.int(byteArray.readDouble());
        }

        byteArray.position = prevOffset;

        return returnValue;
    }

    public function readFloat(targetDataType : DataType) : Float
    {
        var prevOffset = byteArray.position;
        var returnValue:Float;

        switch(targetDataType)
        {
            case DataTypeInt8:
                returnValue =  byteArray.readByte();

            case DataTypeUInt8:
                returnValue =  cast byteArray.readUnsignedByte();

            case DataTypeInt16:
                returnValue =  byteArray.readShort();

            case DataTypeUInt16:
                returnValue =  cast byteArray.readUnsignedShort();

            case DataTypeInt32:
                returnValue =  byteArray.readInt();

            case DataTypeUInt32:
                returnValue =  cast byteArray.readUnsignedInt();

            case DataTypeFloat32:
                returnValue = byteArray.readFloat();

            case DataTypeFloat64:
                returnValue = byteArray.readDouble();
        }

        byteArray.position = prevOffset;

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

        byteArray.position = prevOffset;
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

        byteArray.position = prevOffset;
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

        byteArray.position = prevOffset;
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

        byteArray.position = prevOffset;
    }

    public function toString(?dataType : DataType = null) : String
    {
        if(dataType == null)
        {
            dataType = DataTypeInt32;
        }

        var dataTypeSize : Int = DataTypeUtils.dataTypeByteSize(dataType);
        var prevPosition : Int = byteArray.position;
        var func: types.DataType -> Float;

        if(dataType == DataTypeFloat32 || dataType == DataTypeFloat64){
            func = readFloat;
        }else{
            func = readInt;
        }

        var returnString:String = "";
        var nextPosition : Int;
        byteArray.position = 0;

        while (byteArray.bytesAvailable >0) {

            nextPosition = byteArray.position + dataTypeSize;
            returnString += func(dataType);

            byteArray.position = nextPosition;

            if(byteArray.bytesAvailable>0)returnString += ",";
        }

        byteArray.position = prevPosition;

        return returnString;
    }

    public function resize(newSize : Int) : Void
    {
        var prevPosition : Int = byteArray.position;

        var newBuffer:ByteArray = new ByteArray();
        newBuffer.length = newSize;
        newBuffer.writeBytes(byteArray, 0, byteArray.length);
        _offsetLength = newSize;

        newBuffer.position = prevPosition;

        set_byteArray(newBuffer);
    }


}