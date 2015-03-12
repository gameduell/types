package types;
import flash.utils.Endian;
import flash.utils.ByteArray;
import types.DataType;

class Data
{
    public var internalOffset(get, null) : Int;
    private function get_internalOffset():Int{return 0;}

    public var offset(default, default) : Int;

    public var offsetLength(default, default) : Int;

    public var allocedLength(default, null) : Int;

    public var byteArray(default, set) : ByteArray;
    private var _internalByteArrayOffset : Int = 0;

    public function resetOffset() : Void
    {
        offset = 0;
        offsetLength = allocedLength;
    }

    public function new(sizeInBytes : Int) : Void
    {
        if(sizeInBytes != 0)
        {
            var newByteArray : ByteArray = new ByteArray();
            newByteArray.endian = Endian.LITTLE_ENDIAN;
            newByteArray.length = sizeInBytes;
            newByteArray.position = 0;

            set_byteArray(newByteArray);
        }
    }

    private function set_byteArray(value : ByteArray) : ByteArray
    {
        byteArray = value;
        allocedLength = byteArray.length;
        _internalByteArrayOffset = byteArray.position;
        resetOffset();
        return byteArray;
    }

    public function writeData(data : Data) : Void
    {
        setByteArrayPositionLazily();
        byteArray.writeBytes(data.byteArray, data.offset, data.offsetLength);
        _internalByteArrayOffset += data.offsetLength;
    }

    public function readIntArray(count : Int, targetDataType : DataType) : Array<Int>
    {
        var dataSize = types.DataTypeUtils.dataTypeByteSize(targetDataType);
        var prevOffset = offset;
        var returnArray = new Array<Int>();

        for(i in 0...count)
        {
            offset = prevOffset + (i * dataSize);
            returnArray.push(readInt(targetDataType));
        }

        offset = prevOffset;

        return returnArray;
    }

    public function readUIntArray(count : Int, targetDataType : DataType) : Array<UInt>
    {
        var dataSize = types.DataTypeUtils.dataTypeByteSize(targetDataType);
        var returnArray = new Array<UInt>();
        var prevOffset = offset;

        for(i in 0...count)
        {
            offset = prevOffset + (i * dataSize);
            returnArray.push(readInt(targetDataType));
        }

        offset = prevOffset;

        return returnArray;
    }

    public function readFloatArray(count : Int, targetDataType : DataType) : Array<Float>
    {
        var dataSize = types.DataTypeUtils.dataTypeByteSize(targetDataType);
        var prevOffset = offset;
        var returnArray = new Array<Float>();

        for(i in 0...count)
        {
            offset = prevOffset + (i * dataSize);
            returnArray.push(readFloat(targetDataType));
        }

        offset = prevOffset;

        return returnArray;
    }


    private function setByteArrayPositionLazily() : Void
    {
        if (_internalByteArrayOffset != offset)
        {
            byteArray.position = offset;
            _internalByteArrayOffset = offset;
        }
    }

    private function advanceInternalByteArrayOffset(targetDataType : DataType) : Void
    {
        _internalByteArrayOffset += DataTypeUtils.dataTypeByteSize(targetDataType);
    }

    public function readInt(targetDataType : DataType) : Int
    {
        var returnValue:Int;

        setByteArrayPositionLazily();

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

        advanceInternalByteArrayOffset(targetDataType);

        return returnValue;
    }


    public function readFloat(targetDataType : DataType) : Float
    {
        var returnValue:Float;

        setByteArrayPositionLazily();

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

        advanceInternalByteArrayOffset(targetDataType);

        return returnValue;
    }


    public function writeIntArray(array : Array<Int>, dataType : DataType) : Void
    {
        var dataSize = types.DataTypeUtils.dataTypeByteSize(dataType);
        var prevOffset = offset;

        for(i in 0...array.length)
        {
            offset = prevOffset + (i * dataSize);
            writeInt(array[i], dataType);
        }

        offset = prevOffset;
    }

    public function writeFloatArray(array : Array<Float>, dataType : DataType) : Void
    {
        var dataSize = types.DataTypeUtils.dataTypeByteSize(dataType);
        var prevOffset = offset;

        for(i in 0...array.length)
        {
            offset = prevOffset + (i * dataSize);
            writeFloat(array[i], dataType);
        }

        offset = prevOffset;
    }

    public function writeInt(value : Int, targetDataType : DataType) : Void
    {
        setByteArrayPositionLazily();

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

        advanceInternalByteArrayOffset(targetDataType);
    }

    public function writeFloat(value : Float, targetDataType : DataType) : Void
    {
        setByteArrayPositionLazily();

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

        advanceInternalByteArrayOffset(targetDataType);
    }

    public function toString(?dataType : DataType = null) : String
    {
        if(dataType == null)
        {
            dataType = DataTypeInt32;
        }

        var dataTypeSize : Int = DataTypeUtils.dataTypeByteSize(dataType);
        var prevPosition : Int = offset;
        var func: types.DataType -> Float;

        if(dataType == DataTypeFloat32 || dataType == DataTypeFloat64){
            func = readFloat;
        }else{
            func = readInt;
        }

        var returnString:String = "";
        var nextPosition : Int;
        offset = 0;

        setByteArrayPositionLazily();

        while (byteArray.bytesAvailable > 0)
        {
            nextPosition = offset + dataTypeSize;
            returnString += func(dataType);

            offset = nextPosition;

            if(byteArray.bytesAvailable > 0)returnString += ",";
        }

        offset = prevPosition;

        return returnString;
    }

    public function resize(newSize : Int) : Void
    {
        var newBuffer:ByteArray = new ByteArray();
        newBuffer.endian = Endian.LITTLE_ENDIAN;
        newBuffer.length = newSize;
        newBuffer.position = 0;

        if(allocedLength == 0 || byteArray == null)
        {
                set_byteArray(newBuffer);
                return;
        }

        if (newSize > allocedLength)
        {
            newBuffer.writeBytes(byteArray, 0, allocedLength);
        }
        else
        {
            newBuffer.writeBytes(byteArray, 0, newSize);
        }

        var prevOffsetLength = offsetLength;
        var prevOffset = offset;
        set_byteArray(newBuffer);

        allocedLength = newSize;
        offsetLength = prevOffsetLength;
        offset = prevOffset;
    }

    public function trim() : Void
    {
        if (byteArray == null)
        {
            return;
        }

        var newBuffer:ByteArray = new ByteArray();
        newBuffer.endian = Endian.LITTLE_ENDIAN;
        newBuffer.length = offsetLength;
        newBuffer.position = 0;

        setByteArrayPositionLazily();
        newBuffer.writeBytes(byteArray, offset, offsetLength);
        newBuffer.position = 0;

        set_byteArray(newBuffer);
    }
}