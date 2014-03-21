package types;

import types.DataType;


class Data
{
	public var length(default, null) : Int;

	public function new(sizeInBytes : Int) : Void
	{

	}

	function setFinalizer() 
	{

	} 

	private function setupDataPointer() 
	{

	}

	public function setData(data : Data, offsetInBytes : Int)
	{

	}

	public function setIntArray(array : Array<Int>, offsetInBytes : Int, dataType : DataType) 
	{ 

	}

	public function setFloatArray(array : Array<Float>, offsetInBytes : Int, dataType : DataType) 
	{ 

	}

	public function setInt(value : Int, offsetInBytes : Int, targetDataType : DataType) 
	{

	}

	public function setFloat(value : Float, offsetInBytes : Int, targetDataType : DataType) 
	{

	}

	public function toString(?dataType : DataType) : String
	{ 
		return "";
	}

}