package types;

enum DataType
{
	Byte;
	UnsignedByte;
	Short;
	UnsignedShort;
	Int;
	UnsignedInt;
	Float;
}

class DataTypeUtils
{
	static public function dataTypeByteSize(dataType : DataType) : Int
	{
		switch(dataType)
		{
			case Byte:
				return 1; 
			case UnsignedByte:
				return 1;
			case Short:
				return 2;
			case UnsignedShort:
				return 2;
			case Int:
				return 4;
			case UnsignedInt:
				return 4;
			case Float:
				return 4;
		}
		return 0;
	}
}