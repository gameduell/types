package types;
import flash.utils.Endian;
import flash.utils.ByteArray;
import types.DataType;

class Data
{

    public var offset(get, set) : Int;
    private var _offsetWanted : Int = 0;

    public var offsetLength(get, set) : Int;
    private var _offsetLength : Int = 0;

    public var allocedLength(get, null) : Int;
    private var _allocedLength : Int = 0;

    public var byteArray(default, set) : ByteArray;
    private var _internalByteArrayOffset : Int = 0;


    private function set_offset(value : Int) : Int
    {
        _offsetWanted = value;
        return _offsetWanted;
    }

    private function get_offset() : Int
    {
        return _offsetWanted;
    }

    private function get_allocedLength() : Int
    {
        return _allocedLength;
    }

    private function set_offsetLength(value : Int) : Int
    {
        _offsetLength = value;
        return _offsetLength;
    }

    private function get_offsetLength() : Int
    {
        return _offsetLength;
    }


    public function resetOffset() : Void
    {
        _offsetWanted = 0;
        _offsetLength = _allocedLength;
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
        _allocedLength = byteArray.length;
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
        var prevOffset = _offsetWanted;
        var returnArray = new Array<Int>();

        for(i in 0...count)
        {
            _offsetWanted = prevOffset + (i * dataSize);
            returnArray.push(readInt(targetDataType));
        }

        _offsetWanted = prevOffset;

        return returnArray;
    }

    public function readUIntArray(count : Int, targetDataType : DataType) : Array<UInt>
    {
        var dataSize = types.DataTypeUtils.dataTypeByteSize(targetDataType);
        var returnArray = new Array<UInt>();
        var prevOffset = _offsetWanted;

        for(i in 0...count)
        {
            _offsetWanted = prevOffset + (i * dataSize);
            returnArray.push(readInt(targetDataType));
        }

        _offsetWanted = prevOffset;

        return returnArray;
    }

    public function readFloatArray(count : Int, targetDataType : DataType) : Array<Float>
    {
        var dataSize = types.DataTypeUtils.dataTypeByteSize(targetDataType);
        var prevOffset = _offsetWanted;
        var returnArray = new Array<Float>();

        for(i in 0...count)
        {
            _offsetWanted = prevOffset + (i * dataSize);
            returnArray.push(readFloat(targetDataType));
        }

        _offsetWanted = prevOffset;

        return returnArray;
    }


    private function setByteArrayPositionLazily() : Void
    {
        if (_internalByteArrayOffset != _offsetWanted)
        {
            byteArray.position = _offsetWanted;
            _internalByteArrayOffset = _offsetWanted;
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
        var prevOffset = _offsetWanted;

        for(i in 0...array.length)
        {
            _offsetWanted = prevOffset + (i * dataSize);
            writeInt(array[i], dataType);
        }

        _offsetWanted = prevOffset;
    }

    public function writeFloatArray(array : Array<Float>, dataType : DataType) : Void
    {
        var dataSize = types.DataTypeUtils.dataTypeByteSize(dataType);
        var prevOffset = _offsetWanted;

        for(i in 0...array.length)
        {
            _offsetWanted = prevOffset + (i * dataSize);
            writeFloat(array[i], dataType);
        }

        _offsetWanted = prevOffset;
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
        var prevPosition : Int = _offsetWanted;
        var func: types.DataType -> Float;

        if(dataType == DataTypeFloat32 || dataType == DataTypeFloat64){
            func = readFloat;
        }else{
            func = readInt;
        }

        var returnString:String = "";
        var nextPosition : Int;
        _offsetWanted = 0;

        while (byteArray.bytesAvailable > 0)
        {
            nextPosition = _offsetWanted + dataTypeSize;
            returnString += func(dataType);

            _offsetWanted = nextPosition;

            if(byteArray.bytesAvailable > 0)returnString += ",";
        }

        _offsetWanted = prevPosition;

        return returnString;
    }

    public function resize(newSize : Int) : Void
    {
        var newBuffer:ByteArray = new ByteArray();
        newBuffer.endian = Endian.LITTLE_ENDIAN;
        newBuffer.length = newSize;
        newBuffer.position = 0;

        if (newSize > _allocedLength)
        {
            newBuffer.writeBytes(byteArray, 0, _allocedLength);
        }
        else
        {
            newBuffer.writeBytes(byteArray, 0, newSize);
        }

        set_byteArray(newBuffer);
    }
}