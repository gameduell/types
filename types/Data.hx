package types;

import types.DataType;

@:headerCode("
#include <string>
#include <sstream>
")

@:cppFileCode('							
static void staticClose(types::Data_obj *inObj) 		
{ 										
	if (inObj->_dataPointer)   			
		free(inObj->_dataPointer); 							
}	

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

') 

@:headerClassCode('					
public:								
	void *_dataPointer;				
') 
class Data
{
	public var length(default, null) : Int;

	public function new(sizeInBytes : Int) : Void
	{
		length = sizeInBytes;

		setupDataPointer();
		setFinalizer();
	}

	@:functionCode("
		hx::GCSetFinalizer(this, (hx::finalizer)staticClose);
	") 
	function setFinalizer() {} 

	@:functionCode("
		_dataPointer = (void*)calloc(length, 1);
	") 
	private function setupDataPointer() {}


	@:functionCode("
		memcpy((uint8_t*)_dataPointer + offsetInBytes, data->_dataPointer, data->length);
	") 
	public function setData(data : Data, offsetInBytes : Int)
	{
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

	@:functionCode('
		staticWriteIntIntoPointer((uint8_t*)_dataPointer + offsetInBytes, value, targetDataType);
	') 
	public function setInt(value : Int, offsetInBytes : Int, targetDataType : DataType) {}

	@:functionCode('
		staticWriteFloatIntoPointer((uint8_t*)_dataPointer + offsetInBytes, value, targetDataType);
	') 
	public function setFloat(value : Float, offsetInBytes : Int, targetDataType : DataType) {}


	@:functionCode('
		if(dataType == 0)
			dataType = ::types::DataType_obj::Int;
		int dataSize = ::types::DataTypeUtils_obj::dataTypeByteSize(dataType);

		std::wostringstream oss;

		oss << "[";
		if(length >= 1)
		{
			oss << staticReadValueIntoString(_dataPointer, dataType);
		}

		for(int i = 1; i < length / dataSize; i++)
		{
			oss << ", ";
			oss << staticReadValueIntoString((uint8_t*)_dataPointer + i * dataSize, dataType);
		}

		oss << "]";

		std::wstring str = oss.str();
		
		return ::String(str.c_str(), str.size() + 1);
	') 
	public function toString(?dataType : DataType) : String { return "";}

}