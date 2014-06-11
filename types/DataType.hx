package types;

enum DataType
{
	DataTypeByte;
	DataTypeUnsignedByte;
	DataTypeShort;
	DataTypeUnsignedShort;
	DataTypeInt;
	DataTypeUnsignedInt;
	DataTypeFloat;
    DataTypeDouble;
}

class DataTypeUtils
{
	static public function dataTypeByteSize(dataType : DataType) : Int
	{
		switch(dataType)
		{
			case DataTypeByte:
				return 1; 
			case DataTypeUnsignedByte:
				return 1;
			case DataTypeShort:
				return 2;
			case DataTypeUnsignedShort:
				return 2;
			case DataTypeInt:
				return 4;
			case DataTypeUnsignedInt:
				return 4;
			case DataTypeFloat:
				return 4;
            case DataTypeDouble:
                return 8;
		}
		return 0;
	}
}