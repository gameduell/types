package types;

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
	private var _offset : Int;
	private var _offsetLength : Int;
	private var _allocedLength : Int;

	public var allocedLength(get, never) : Int;
	public function get_allocedLength() : Int
	{
		return _allocedLength;
	}

	public var offset(get, set) : Int;

	public function set_offset(value : Int) : Int
	{
		_offset = value;

		return _offset;
	}

	public function get_offset() : Int
	{
		return _offset;
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
	public var stringView : StringView;

	public function new(sizeInBytes : Int) : Void
	{
		if(sizeInBytes != 0)
		{
			_offsetLength = sizeInBytes;
			_offset = 0;
			arrayBuffer = new ArrayBuffer(sizeInBytes);
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

	 	if(length % 2  == 0)
	 	{
	 		int16Array = new Int16Array(arrayBuffer);
	 		uint16Array = new Uint16Array(arrayBuffer);
	 	}
	 	if(length % 4  == 0)
	 	{
	 		int32Array = new Int32Array(arrayBuffer);
	 		uint32Array = new Uint32Array(arrayBuffer);
	 		float32Array = new Float32Array(arrayBuffer);
	 	}

	}


	public function setData(data : Data) : Void
	{
		var subarrayView = data.uint8Array.subarray(data._offset, data._offset + data._offsetLength);
		uint8Array.set(subarrayView, offset);
	}

	public function getInt(targetDataType : DataType) : Int
	{
		switch(targetDataType)
		{
			case DataTypeByte:
				return int8Array[_offset];
			case DataTypeUnsignedByte:
				return uint8Array[_offset];
			case DataTypeShort:
				return int16Array[cast _offset / 2];
			case DataTypeUnsignedShort:
				return uint16Array[cast _offset / 2];
			case DataTypeInt:
				return int32Array[cast _offset / 4];
			case DataTypeUnsignedInt:
				return uint32Array[cast _offset / 4];
			case DataTypeFloat:
				return cast float32Array[cast _offset / 4];
		}
		return 0;
	}

	public function getFloat(targetDataType : DataType) : Float
	{
		switch(targetDataType)
		{
			case DataTypeByte:
				return cast int8Array[_offset];
			case DataTypeUnsignedByte:
				return cast uint8Array[_offset];
			case DataTypeShort:
				return cast int16Array[cast _offset / 2];
			case DataTypeUnsignedShort:
				return cast uint16Array[cast _offset / 2];
			case DataTypeInt:
				return cast int32Array[cast _offset / 4];
			case DataTypeUnsignedInt:
				return cast uint32Array[cast _offset / 4];
			case DataTypeFloat:
				return float32Array[cast _offset / 4];
		}
		return 0;
	}


	public function setIntArray(array : Array<Int>, dataType : DataType) : Void 
	{ 
		var dataSize = types.DataTypeUtils.dataTypeByteSize(dataType);

		var prevOffset = _offset;
		for(i in 0...array.length)
		{
			setInt(array[i], dataType);

			_offset += dataSize;
		}
		_offset = prevOffset;
	}

	public function setFloatArray(array : Array<Float>, dataType : DataType) : Void 
	{ 
		var dataSize = types.DataTypeUtils.dataTypeByteSize(dataType);

		var prevOffset = _offset;
		for(i in 0...array.length)
		{
			setFloat(array[i], dataType);

			_offset += dataSize;
		}
		_offset = prevOffset;
	}

	static var intArrayOf1 : Array<Int> = [0];
	public function setInt(value : Int, targetDataType : DataType) : Void 
	{
		intArrayOf1[0] = value;
		switch(targetDataType)
		{
			case DataTypeByte:
				int8Array.set(intArrayOf1, _offset);
				return; 
			case DataTypeUnsignedByte:
				uint8Array.set(intArrayOf1, _offset);
				return;
			case DataTypeShort:
				int16Array.set(intArrayOf1, cast _offset / 2);
				return;
			case DataTypeUnsignedShort:
				uint16Array.set(intArrayOf1, cast _offset / 2);
				return;
			case DataTypeInt:
				int32Array.set(intArrayOf1, cast _offset / 4);
				return;
			case DataTypeUnsignedInt:
				uint32Array.set(intArrayOf1, cast _offset / 4);
				return;
			case DataTypeFloat:
				float32Array.set(intArrayOf1, cast _offset / 4);
				return;
		}
		return;
	}

	public function setFloat(value : Float, targetDataType : DataType) : Void 
	{	
		intArrayOf1[0] = cast value;
		switch(targetDataType)
		{
			case DataTypeByte:
				int8Array.set(intArrayOf1, _offset);
				return; 
			case DataTypeUnsignedByte:
				uint8Array.set(intArrayOf1, _offset);
				return;
			case DataTypeShort:
				int16Array.set(intArrayOf1, cast _offset / 2);
				return;
			case DataTypeUnsignedShort:
				uint16Array.set(intArrayOf1, cast _offset / 2);
				return;
			case DataTypeInt:
				int32Array.set(intArrayOf1, cast _offset / 4);
				return;
			case DataTypeUnsignedInt:
				uint32Array.set(intArrayOf1, cast _offset / 4);
				return;
			case DataTypeFloat:
				float32Array.set(intArrayOf1, cast _offset / 4);
				return;
		}
		return;
	}

	public function toString(?dataType : DataType) : String
	{ 
		var output = "";
		output += "[";

		var view : Dynamic;
		switch(dataType)
		{
			case DataTypeByte:
				view = int8Array;
			case DataTypeUnsignedByte:
				view = uint8Array;
			case DataTypeShort:
				view = uint16Array;
			case DataTypeUnsignedShort:
				view = uint16Array;
			case DataTypeInt:
				view = int32Array;
			case DataTypeUnsignedInt:
				view = uint32Array;
			case DataTypeFloat:
				view = float32Array;
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
	}


}