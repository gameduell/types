package types;

import js.html.DataView;
import types.DataType;
import js.html.ArrayBuffer;
import js.html.ArrayBufferView;
import js.html.Int8Array;
import js.html.Uint8Array;
import js.html.Int16Array;
import js.html.Uint16Array;
import js.html.Int32Array;
import js.html.Uint32Array;
import js.html.Float32Array;
import js.html.Float64Array;
import js.html.StringView;


class Data
{
	private var _offset : Int = 0;
	private var _offsetLength : Int = 0;
	private var _allocedLength : Int = 0;

	public var allocedLength(get, never) : Int;
	private function get_allocedLength() : Int
	{
		return _allocedLength;
	}

	public var offset(get, set) : Int;

	private function set_offset(value : Int) : Int
	{
        if(value == null)
            _offset = 0;
        else
		    _offset = value;

		return _offset;
	}

	private function get_offset() : Int
	{
		return _offset;
	}

	public var offsetLength(get, set) : Int;

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
		_offset = 0;
		_offsetLength = allocedLength;
	}


	public var arrayBuffer(default, set) : ArrayBuffer;

	public var int8Array : Int8Array;
	public var uint8Array : Uint8Array;
	public var int16Array : Int16Array;
	public var uint16Array : Uint16Array;
	public var int32Array : Int32Array;
	public var uint32Array : Uint32Array;
	public var float32Array : Float32Array;
    public var float64Array : Float64Array;
    public var dataView : DataView;
	public var stringView : StringView;

	public function new(sizeInBytes : Int) : Void
	{
		if(sizeInBytes != 0)
		{
			_offsetLength = sizeInBytes;
			_offset = 0;
            set_arrayBuffer(new ArrayBuffer(sizeInBytes));
		}

		_allocedLength = sizeInBytes;
	}

	///for usage in html5 haxelibs
	public function set_arrayBuffer(value : ArrayBuffer) : ArrayBuffer
	{
	 	arrayBuffer = value;
	 	_allocedLength = value.byteLength;

		_offsetLength = _allocedLength;
		_offset = 0;

	 	remakeViews();

		return value;
	}

	private function remakeViews() : Void
	{
		var length = arrayBuffer.byteLength;

		int8Array = new Int8Array(arrayBuffer);
	 	uint8Array = new Uint8Array(arrayBuffer);
	 	stringView = new StringView(arrayBuffer);

        var truncated2Mult : Int = cast ((length - length % 2) / 2);
        int16Array = new Int16Array(arrayBuffer, 0, truncated2Mult);
        uint16Array = new Uint16Array(arrayBuffer, 0, truncated2Mult);

        var truncated4Mult : Int = cast ((length - length % 4) / 4);
        int32Array = new Int32Array(arrayBuffer, 0, truncated4Mult);
        uint32Array = new Uint32Array(arrayBuffer, 0, truncated4Mult);
        float32Array = new Float32Array(arrayBuffer, 0, truncated4Mult);

        var truncated8Mult : Int = cast ((length - length % 8) / 8);
        float64Array = new Float64Array(arrayBuffer, 0, truncated8Mult);

        dataView = new DataView(arrayBuffer);
	}


	public function writeData(data : Data) : Void
	{
		var subarrayView = data.uint8Array.subarray(data._offset, data._offset + data._offsetLength);
		uint8Array.set(subarrayView, offset);
	}

	public function readInt(targetDataType : DataType) : Int
	{
		switch(targetDataType)
		{
			case DataTypeInt8:
				return int8Array[_offset];
			case DataTypeUInt8:
				return uint8Array[_offset];
			case DataTypeInt16:
                if(_offset % 2 == 0)
				    return int16Array[cast _offset / 2];
                else
                    return dataView.getInt16(_offset, true);
			case DataTypeUInt16:
                if(_offset % 2 == 0)
				    return uint16Array[cast _offset / 2];
                else
                    return dataView.getUint16(_offset, true);
			case DataTypeInt32:
                if(_offset % 4 == 0)
				    return int32Array[cast _offset / 4];
                else
                    return dataView.getInt32(_offset, true);
			case DataTypeUInt32:
                if(_offset % 4 == 0)
				    return uint32Array[cast _offset / 4];
                else
                    return dataView.getUint32(_offset, true);
			case DataTypeFloat32:
                if(_offset % 4 == 0)
				    return cast float32Array[cast _offset / 4];
                else
                    return cast dataView.getFloat32(_offset, true);
            case DataTypeFloat64:
                if(_offset % 8 == 0)
                    return cast float64Array[cast _offset / 8];
                else
                    return cast dataView.getFloat64(_offset, true);
		}
		return 0;
	}

	public function readFloat(targetDataType : DataType) : Float
	{
		switch(targetDataType)
		{
			case DataTypeInt8:
				return cast int8Array[_offset];
			case DataTypeUInt8:
				return cast uint8Array[_offset];
			case DataTypeInt16:
                if(_offset % 2 == 0)
				    return cast int16Array[cast _offset / 2];
                else
                    return cast dataView.getInt16(_offset, true);
			case DataTypeUInt16:
                if(_offset % 2 == 0)
				    return cast uint16Array[cast _offset / 2];
                else
                    return cast dataView.getUint16(_offset, true);
			case DataTypeInt32:
                if(_offset % 4 == 0)
				    return cast int32Array[cast _offset / 4];
                else
                    return cast dataView.getInt32(_offset, true);
			case DataTypeUInt32:
                if(_offset % 4 == 0)
				    return cast uint32Array[cast _offset / 4];
                else
                    return cast dataView.getUint32(_offset, true);
			case DataTypeFloat32:
                if(_offset % 4 == 0)
				    return float32Array[cast _offset / 4];
                else
                    return dataView.getFloat32(_offset, true);
            case DataTypeFloat64:
                if(_offset % 8 == 0)
                    return float64Array[cast _offset / 8];
                else
                    return dataView.getFloat64(_offset, true);
		}
		return 0;
	}


	public function writeIntArray(array : Array<Int>, dataType : DataType) : Void 
	{ 
		var dataSize = types.DataTypeUtils.dataTypeByteSize(dataType);

		var prevOffset = _offset;
		for(i in 0...array.length)
		{
			writeInt(array[i], dataType);

			_offset += dataSize;
		}
		_offset = prevOffset;
	}

	public function writeFloatArray(array : Array<Float>, dataType : DataType) : Void 
	{ 
		var dataSize = types.DataTypeUtils.dataTypeByteSize(dataType);

		var prevOffset = _offset;
		for(i in 0...array.length)
		{
			writeFloat(array[i], dataType);

			_offset += dataSize;
		}
		_offset = prevOffset;
	}

    public function readIntArray(count : Int, dataType : DataType) : Array<Int>
    {
        var dataSize = types.DataTypeUtils.dataTypeByteSize(dataType);

        var prevOffset = get_offset();
        var currentOffset = prevOffset;

        var array = new Array<Int>();
        for(i in 0...count)
        {
            set_offset(currentOffset);
            array.push(readInt(dataType));

            currentOffset += dataSize;
        }
        set_offset(prevOffset);
        return array;
    }

    public function readFloatArray(count : Int, dataType : DataType) : Array<Float>
    {
        var dataSize = types.DataTypeUtils.dataTypeByteSize(dataType);

        var prevOffset = get_offset();
        var currentOffset = prevOffset;

        var array = new Array<Float>();
        for(i in 0...count)
        {
            set_offset(currentOffset);
            array.push(readFloat(dataType));

            currentOffset += dataSize;
        }
        set_offset(prevOffset);
        return array;
    }


	public function writeInt(value : Int, targetDataType : DataType) : Void 
	{
		switch(targetDataType)
		{
			case DataTypeInt8:
				int8Array[_offset] = value;
				return; 
			case DataTypeUInt8:
                uint8Array[_offset] = value;
				return;
			case DataTypeInt16:
                if(_offset % 2 == 0)
                    int16Array[cast _offset / 2] = value;
                else
                    dataView.setInt16(_offset, value, true);
				return;
			case DataTypeUInt16:
                if(_offset % 2 == 0)
                    uint16Array[cast _offset / 2] = value;
                else
                    dataView.setUint16(_offset, value, true);
				return;
			case DataTypeInt32:
                if(_offset % 4 == 0)
                    int32Array[cast _offset / 4] = value;
                else
                    dataView.setInt32(_offset, value, true);
				return;
			case DataTypeUInt32:
                if(_offset % 4 == 0)
                    uint32Array[cast _offset / 4] = value;
                else
                    dataView.setUint32(_offset, value, true);
				return;
			case DataTypeFloat32:
                if(_offset % 4 == 0)
                    float32Array[cast _offset / 4] = value;
                else
                    dataView.setFloat32(_offset, cast value, true);
				return;
            case DataTypeFloat64:
                if(_offset % 8 == 0)
                    float64Array[cast _offset / 8] = value;
                else
                    dataView.setFloat64(_offset, cast value, true);
                return;
		}
		return;
	}

	public function writeFloat(value : Float, targetDataType : DataType) : Void 
	{
        switch(targetDataType)
        {
            case DataTypeInt8:
                int8Array[_offset] =  cast value;
                return;
            case DataTypeUInt8:
                uint8Array[_offset] = cast value;
                return;
            case DataTypeInt16:
                if(_offset % 2 == 0)
                    int16Array[cast _offset / 2] = cast value;
                else
                    dataView.setInt16(_offset, cast value, true);
                return;
            case DataTypeUInt16:
                if(_offset % 2 == 0)
                    uint16Array[cast _offset / 2] = cast value;
                else
                    dataView.setUint16(_offset, cast value, true);
                return;
            case DataTypeInt32:
                if(_offset % 4 == 0)
                    int32Array[cast _offset / 4] = cast value;
                else
                    dataView.setInt32(_offset, cast value, true);
                return;
            case DataTypeUInt32:
                if(_offset % 4 == 0)
                    uint32Array[cast _offset / 4] = cast value;
                else
                    dataView.setUint32(_offset, cast value, true);
                return;
            case DataTypeFloat32:
                if(_offset % 4 == 0)
                    float32Array[cast _offset / 4] = value;
                else
                    dataView.setFloat32(_offset, value, true);
                return;
            case DataTypeFloat64:
                if(_offset % 8 == 0)
                    float64Array[cast _offset / 8] = value;
                else
                    dataView.setFloat64(_offset, value, true);
                return;
        }
        return;
	}

	public function toString(?dataType : DataType) : String
	{
		if(dataType == null)
		{
			dataType = DataTypeInt32;
		}

		var output = "";
		output += "[";

		var view : Dynamic;
		switch(dataType)
		{
			case DataTypeInt8:
				view = int8Array;
			case DataTypeUInt8:
				view = uint8Array;
			case DataTypeInt16:
				view = uint16Array;
			case DataTypeUInt16:
				view = uint16Array;
			case DataTypeInt32:
				view = int32Array;
			case DataTypeUInt32:
				view = uint32Array;
			case DataTypeFloat32:
				view = float32Array;
            case DataTypeFloat64:
                view = float64Array;
		}

		var dataSize = DataTypeUtils.dataTypeByteSize(dataType);

		var count : Int = cast arrayBuffer.byteLength / dataSize;

		if(count > 0)
		{
			output += view[0];
		}

		for(i in 1...count)
		{
			output += ", ";
			output += view[i];
		}

		output += "]";
		return output;
	}

	public function resize(newSize : Int) : Void 
	{
    	var newBuffer = new ArrayBuffer(newSize);
    	var prevBuffer = arrayBuffer;
    	var prevBufferView = uint8Array;
    	var prevOffset = _offset;
    	var prevOffsetLength = _offsetLength;

    	set_arrayBuffer(newBuffer);

    	if(prevBuffer != null)
    	{

	    	if(newSize < prevBuffer.byteLength)
	    	{
	    		uint8Array.set(prevBufferView.subarray(0, newSize));
	    	}
	    	else
	    	{
	    		uint8Array.set(prevBufferView);
	    	}

    	}
    	_allocedLength = newSize;
    	_offsetLength = prevOffsetLength;
    	_offset = prevOffset;
	}

    public function trim() : Void
    {
    	if(arrayBuffer == null)
    	{
    		return;
    	}

    	var newBuffer = new ArrayBuffer(offsetLength);
    	var prevBuffer = arrayBuffer;
    	var prevBufferView = uint8Array;
    	var prevOffset = offset;
    	var prevOffsetLength = offsetLength;

    	set_arrayBuffer(newBuffer);

    	uint8Array.set(prevBufferView.subarray(prevOffset, prevOffset + prevOffsetLength));
    }
}