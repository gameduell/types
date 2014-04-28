package types;

import types.DataType;

extern class Data
{
	public function new(sizeInBytes : Int) : Void; /// if 0, empty data, does not create the underlying memory. Can be set externally.

	public function setData(data : Data) : Void;

	public function setInt(value : Int, targetDataType : DataType) : Void;

	public function setFloat(value : Float, targetDataType : DataType) : Void;

	public function setIntArray(array : Array<Int>, dataType : DataType) : Void;

	public function setFloatArray(array : Array<Float>, dataType : DataType) : Void;

	public function getInt(targetDataType : DataType) : Int;

	public function getFloat(targetDataType : DataType) : Float;

	public function toString(?dataType : DataType) : String; /// defaults to DataType.Int

	/// offset view, all uses of data should start at offset and use up to offset length
	public var offset(get, set) : Int;
	public var offsetLength(get, set) : Int;
	public function resetOffset() : Void; /// makes offset 0 and offsetLength be allocedLength

	/// should not be used for reading and writing on the data
	public var allocedLength(get, never) : Int;

	/// if underlying pointer is set externally a new pointer will be created with a copy of that external pointer's memory.
	public function resize(newSize : Int) : Void;
}