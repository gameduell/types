package types;

import types.DataType;

import cpp.Lib;

@:buildXml('

	<files id="haxe">

		<include name="${haxelib:types_cpp}/native.xml" />

	</files>

')

@:headerCode("
#include <types/NativeData.h>
")

@:cppFileCode('

#include <string>
#include <sstream>
#include <stdio.h>

static inline std::wstring staticReadValueIntoString(void *pointer, types::DataType &dataType)
{
	std::wostringstream oss;
	switch( (int)(dataType->__Index())){
		case (int)0: {
			oss << (int)(((int8_t*)pointer)[0]);
		}
		;break;
		case (int)1: {
			oss << (int)(((uint8_t*)pointer)[0]);
		}
		;break;
		case (int)2: {
			oss << (int)(((int16_t*)pointer)[0]);
		}
		;break;
		case (int)3: {
			oss << (int)(((uint16_t*)pointer)[0]);
		}
		;break;
		case (int)4: {
			oss << ((int32_t*)pointer)[0];
		}
		;break;
		case (int)5: {
			oss << ((uint32_t*)pointer)[0];
		}
		;break;
		case (int)6: {
			oss << ((float*)pointer)[0];
		}
		;break;
	}
	return oss.str();
}

static inline void staticWriteFloatIntoPointer(void *pointer, float value, types::DataType &dataType)
{
	switch( (int)(dataType->__Index())){
		case (int)0: {
			((int8_t*)pointer)[0] = (int8_t)value;
		}
		;break;
		case (int)1: {
			((uint8_t*)pointer)[0] = (uint8_t)value;
		}
		;break;
		case (int)2: {
			((int16_t *)pointer)[0] = (uint16_t)value;
		}
		;break;
		case (int)3: {
			((uint16_t *)pointer)[0] = (int16_t)value;
		}
		;break;
		case (int)4: {
			((int32_t *)pointer)[0] = (int32_t)value;
		}
		;break;
		case (int)5: {
			((uint32_t *)pointer)[0] = (uint32_t)value;
		}
		;break;
		case (int)6: {
			((float *)pointer)[0] = (float)value;
		}
		;break;
	}
}

static inline float staticReadFloatFromPointer(void *pointer, types::DataType &dataType)
{
	switch( (int)(dataType->__Index())){
		case (int)0: {
			return (float)(((int8_t*)pointer)[0]);
		}
		case (int)1: {
			return (float)(((uint8_t*)pointer)[0]);
		}
		case (int)2: {
			return (float)(((int16_t*)pointer)[0]);
		}
		case (int)3: {
			return (float)(((uint16_t*)pointer)[0]);
		}
		case (int)4: {
			return (float)(((int32_t*)pointer)[0]);
		}
		case (int)5: {
			return (float)(((uint32_t*)pointer)[0]);
		}
		case (int)6: {
			return ((float*)pointer)[0];
		}
	}
	return 0;
}

static inline void staticWriteIntIntoPointer(void *pointer, int &value, types::DataType &dataType)
{
	switch( (int)(dataType->__Index())){
		case (int)0: {
			((int8_t*)pointer)[0] = (int8_t)value;
		}
		;break;
		case (int)1: {
			((uint8_t*)pointer)[0] = (uint8_t)value;
		}
		;break;
		case (int)2: {
			((int16_t *)pointer)[0] = (uint16_t)value;
		}
		;break;
		case (int)3: {
			((uint16_t *)pointer)[0] = (int16_t)value;
		}
		;break;
		case (int)4: {
			((int32_t *)pointer)[0] = (int32_t)value;
		}
		;break;
		case (int)5: {
			((uint32_t *)pointer)[0] = (uint32_t)value;
		}
		;break;
		case (int)6: {
			((float *)pointer)[0] = (float)value;
		}
		;break;
	}
}

static inline int staticReadIntFromPointer(void *pointer, types::DataType &dataType)
{
	switch( (int)(dataType->__Index())){
		case (int)0: {
			return (int)(((int8_t*)pointer)[0]);
		}
		case (int)1: {
			return (int)(((uint8_t*)pointer)[0]);
		}
		case (int)2: {
			return (int)(((int16_t*)pointer)[0]);
		}
		case (int)3: {
			return (int)(((uint16_t*)pointer)[0]);
		}
		case (int)4: {
			return (int)(((int32_t*)pointer)[0]);
		}
		case (int)5: {
			return (int)(((uint32_t*)pointer)[0]);
		}
		case (int)6: {
			return ((int*)pointer)[0];
		}
	}
	return 0;
}


') 

@:headerClassCode('					
public:								
	NativeData *_nativeData; ///this gets dealloced by the GC since it is tied to "nativeData" with alloc_abstract
') 
class Data
{

	/// CONSTRUCTOR
	public function new(sizeInBytes : Int) : Void
	{
		setupHaxeNativeData();
		if(sizeInBytes != 0)
		{
			setup(sizeInBytes);
		}
	}

	public var nativeData : Dynamic;
	public static var nativedata_createNativeData = Lib.load ("nativedata", "nativedata_createNativeData", 0);

	@:functionCode("
		nativeData = nativedata_createNativeData();
		_nativeData = (NativeData*)nativeData->__GetHandle();
	") 
	private function setupHaxeNativeData() : Void {}

	@:functionCode("
		_nativeData->setup(length);
	") 
	private function setup(length : Int) : Void {}

	/// PROPERTIES
	public var allocedLength(get, never) : Int;
	@:functionCode("
		return _nativeData->allocedLength;
	") 
	private function get_allocedLength() : Int { return 0; }

	public var offset(get, set) : Int;
	@:functionCode("
		return _nativeData->offset;
	") 
	private function get_offset() : Int { return 0; }

	@:functionCode("
		_nativeData->offset = offset;
		return _nativeData->offset;
	") 
	private function set_offset(offset : Int) : Int { return 0; }

	public var offsetLength(get, set) : Int;

	@:functionCode("
		return _nativeData->offsetLength;
	") 
	private function get_offsetLength() : Int { return 0; }

	@:functionCode("
		_nativeData->offsetLength = offsetLength;
		return _nativeData->offsetLength;
	") 
	private function set_offsetLength(offsetLength : Int) : Int { return 0; }

	@:functionCode("
		_nativeData->offsetLength = _nativeData->allocedLength;
		_nativeData->offset = 0;
	") 
	public function resetOffset() : Void {} ///makes offset 0 and offsetLength be length

	/// METHODS
	@:functionCode("
		_nativeData->writeData(data->_nativeData);
	") 
	public function setData(data : Data) : Void {}

	public function setIntArray(array : Array<Int>, dataType : DataType) : Void
	{ 
		var dataSize = types.DataTypeUtils.dataTypeByteSize(dataType);

		var prevOffset = get_offset();
		var currentOffset = prevOffset;
		for(i in 0...array.length)
		{
			set_offset(currentOffset);
			setInt(array[i], dataType);

			currentOffset += dataSize;
		}
		set_offset(prevOffset);
	}

	public function setFloatArray(array : Array<Float>, dataType : DataType) : Void
	{ 
		var dataSize = types.DataTypeUtils.dataTypeByteSize(dataType);

		var prevOffset = get_offset();
		var currentOffset = prevOffset;
		for(i in 0...array.length)
		{
			set_offset(currentOffset);
			setFloat(array[i], dataType);

			currentOffset += dataSize;
		}
		set_offset(prevOffset);
	}

	@:functionCode('
		staticWriteIntIntoPointer(_nativeData->ptr + _nativeData->offset, value, targetDataType);
	') 
	public function setInt(value : Int, targetDataType : DataType) : Void {}

	@:functionCode('
		staticWriteFloatIntoPointer(_nativeData->ptr + _nativeData->offset, value, targetDataType);
	') 
	public function setFloat(value : Float, targetDataType : DataType) : Void {}

	@:functionCode('
		return staticReadIntFromPointer(_nativeData->ptr + _nativeData->offset, targetDataType);
	') 
	public function getInt(targetDataType : DataType) : Int { return 0; }

	@:functionCode('
		return staticReadFloatFromPointer(_nativeData->ptr + _nativeData->offset, targetDataType);
	') 
	public function getFloat(targetDataType : DataType) : Float { return 0; }

	@:functionCode('
		if(dataType == 0)
			dataType = ::types::DataType_obj::DataTypeInt;
		int dataSize = ::types::DataTypeUtils_obj::dataTypeByteSize(dataType);

		std::wostringstream oss;

		oss << "[";
		if(_nativeData->allocedLength >= 1)
		{
			oss << staticReadValueIntoString(_nativeData->ptr, dataType);
		}

		for(int i = 1; i < _nativeData->allocedLength / dataSize; i++)
		{
			oss << ", ";
			oss << staticReadValueIntoString(_nativeData->ptr + i * dataSize, dataType);
		}

		oss << "]";

		std::wstring str = oss.str();
		
		return ::String(str.c_str(), str.size() + 1);
	') 
	public function toString(?dataType : DataType) : String { return "";}

}