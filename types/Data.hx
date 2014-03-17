package types;

import DataType;

extern Class Data
{
	public function new(sizeInBytes : Int) : Void;

	public function setData(data : Data, offsetInBytes : Int);

	public function setValue(value : Dynamic, offsetInBytes : Int, dataType : DataType);

	public function setArray(array : Array<Dynamic>, offsetInBytes : Int, dataType : DataType);

	public function toString(?dataType : DataType) : String; /// defaults to DataType.Int

	public var length(default, null) : Int;
}