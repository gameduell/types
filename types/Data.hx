package types;

import DataType;

extern Class Data
{
	public function new(sizeInBytes : Int) : Void;

	public function setData(data : Data, offsetInBytes : Int);

	public function setInt(value : Int, offsetInBytes : Int, targetDataTyoe : DataType);

	public function setFloat(value : Float, offsetInBytes : Int, targetDataTyoe : DataType);

	public function setIntArray(array : Array<Int>, offsetInBytes : Int, dataType : DataType);

	public function setFloatArray(array : Array<Float>, offsetInBytes : Int, dataType : DataType);

	public function toString(?dataType : DataType) : String; /// defaults to DataType.Int

	public var length(default, null) : Int;
}