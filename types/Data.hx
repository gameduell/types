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

class Data
{
	public var length(default, null) : Int;

	public var arrayBuffer(default, set) : ArrayBuffer;

	public var int8Array : Int8Array;
	public var uint8Array : Uint8Array;
	public var int16Array : Int16Array;
	public var uint16Array : Uint16Array;
	public var int32Array : Int32Array;
	public var uint32Array : Uint32Array;
	public var float32Array : Float32Array;

	public function new(sizeInBytes : Int) : Void
	{
		if(sizeInBytes != 0)
		{
			arrayBuffer = new ArrayBuffer(sizeInBytes);
		}

		length = sizeInBytes;
	}

	///for usage in html5 haxelibs
	public function set_arrayBuffer(value : ArrayBuffer)
	{
		var length = value.byteLength;

		int8Array = new Int8Array(value);
	 	uint8Array = new Uint8Array(value);
	 	if(length % 2  == 0)
	 	{
	 		int16Array = new Int16Array(value);
	 		uint16Array = new Uint16Array(value);
	 	}
	 	if(length % 4  == 0)
	 	{
	 		int32Array = new Int32Array(value);
	 		uint32Array = new Uint32Array(value);
	 		float32Array = new Float32Array(value);
	 	}

	 	arrayBuffer = value;

		return value;
	}

	public function setData(data : Data, offsetInBytes : Int, lengthInBytes : Int)
	{
		if(lengthInBytes == data.length)
		{
			uint8Array.set(data.uint8Array, offsetInBytes);
		}
		else
		{ 
			var subarray = data.uint8Array.subarray(offsetInBytes, offsetInBytes + lengthInBytes);
			uint8Array.set(subarray);
		}
	}

	public function getInt(offsetInBytes : Int, targetDataType : DataType) : Int
	{
		switch(targetDataType)
		{
			case DataTypeByte:
				return int8Array[offsetInBytes];
			case DataTypeUnsignedByte:
				return uint8Array[offsetInBytes];
			case DataTypeShort:
				return int16Array[cast offsetInBytes / 2];
			case DataTypeUnsignedShort:
				return uint16Array[cast offsetInBytes / 2];
			case DataTypeInt:
				return int32Array[cast offsetInBytes / 4];
			case DataTypeUnsignedInt:
				return uint32Array[cast offsetInBytes / 4];
			case DataTypeFloat:
				return cast float32Array[cast offsetInBytes / 4];
		}
		return 0;
	}

	public function getFloat(offsetInBytes : Int, targetDataType : DataType) : Float
	{
		switch(targetDataType)
		{
			case DataTypeByte:
				return cast int8Array[offsetInBytes];
			case DataTypeUnsignedByte:
				return cast uint8Array[offsetInBytes];
			case DataTypeShort:
				return cast int16Array[cast offsetInBytes / 2];
			case DataTypeUnsignedShort:
				return cast uint16Array[cast offsetInBytes / 2];
			case DataTypeInt:
				return cast int32Array[cast offsetInBytes / 4];
			case DataTypeUnsignedInt:
				return cast uint32Array[cast offsetInBytes / 4];
			case DataTypeFloat:
				return float32Array[cast offsetInBytes / 4];
		}
		return 0;
	}


	public function setIntArray(array : Array<Int>, offsetInBytes : Int, dataType : DataType) 
	{ 
		var dataSize = types.DataTypeUtils.dataTypeByteSize(dataType);

		var currentOffset = offsetInBytes;
		for(i in 0...array.length)
		{
			setInt(array[i], currentOffset, dataType);

			currentOffset += dataSize;
		}
	}

	public function setFloatArray(array : Array<Float>, offsetInBytes : Int, dataType : DataType) 
	{ 
		var dataSize = types.DataTypeUtils.dataTypeByteSize(dataType);

		var currentOffset = offsetInBytes;
		for(i in 0...array.length)
		{
			setFloat(array[i], currentOffset, dataType);

			currentOffset += dataSize;
		}
	}

	static var intArrayOf1 : Array<Int> = [0];
	public function setInt(value : Int, offsetInBytes : Int, targetDataType : DataType) 
	{
		intArrayOf1[0] = value;
		switch(targetDataType)
		{
			case DataTypeByte:
				int8Array.set(intArrayOf1, offsetInBytes);
				return; 
			case DataTypeUnsignedByte:
				uint8Array.set(intArrayOf1, offsetInBytes);
				return;
			case DataTypeShort:
				int16Array.set(intArrayOf1, cast offsetInBytes / 2);
				return;
			case DataTypeUnsignedShort:
				uint16Array.set(intArrayOf1, cast offsetInBytes / 2);
				return;
			case DataTypeInt:
				int32Array.set(intArrayOf1, cast offsetInBytes / 4);
				return;
			case DataTypeUnsignedInt:
				uint32Array.set(intArrayOf1, cast offsetInBytes / 4);
				return;
			case DataTypeFloat:
				float32Array.set(intArrayOf1, cast offsetInBytes / 4);
				return;
		}
		return;
	}

	public function setFloat(value : Float, offsetInBytes : Int, targetDataType : DataType) 
	{	
		intArrayOf1[0] = cast value;
		switch(targetDataType)
		{
			case DataTypeByte:
				int8Array.set(intArrayOf1, offsetInBytes);
				return; 
			case DataTypeUnsignedByte:
				uint8Array.set(intArrayOf1, offsetInBytes);
				return;
			case DataTypeShort:
				int16Array.set(intArrayOf1, cast offsetInBytes / 2);
				return;
			case DataTypeUnsignedShort:
				uint16Array.set(intArrayOf1, cast offsetInBytes / 2);
				return;
			case DataTypeInt:
				int32Array.set(intArrayOf1, cast offsetInBytes / 4);
				return;
			case DataTypeUnsignedInt:
				uint32Array.set(intArrayOf1, cast offsetInBytes / 4);
				return;
			case DataTypeFloat:
				float32Array.set(intArrayOf1, cast offsetInBytes / 4);
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

}