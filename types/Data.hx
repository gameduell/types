package types;

import types.DataType;

extern class Data
{
	public function new(sizeInBytes : Int) : Void; /// if 0, empty data, does not create the underlying memory. Can be set externally.

	public function setData(data : Data, offsetInBytes : Int, lengthInBytes : Int) : Void;

	public function setInt(value : Int, offsetInBytes : Int, targetDataTyoe : DataType) : Void;

	public function setFloat(value : Float, offsetInBytes : Int, targetDataTyoe : DataType) : Void;

	public function setIntArray(array : Array<Int>, offsetInBytes : Int, dataType : DataType) : Void;

	public function setFloatArray(array : Array<Float>, offsetInBytes : Int, dataType : DataType) : Void;

	public function getInt(offsetInBytes : Int, targetDataType : DataType) : Int;

	public function getFloat(offsetInBytes : Int, targetDataType : DataType) : Float;

	public function toString(?dataType : DataType) : String; /// defaults to DataType.Int

	public var length(default, null) : Int;
}