package types;

enum DataType
{
	DataTypeInt8;
	DataTypeUInt8;
	DataTypeInt16;
	DataTypeUInt16;
	DataTypeInt32;
	DataTypeUInt32;
	DataTypeFloat32;
    DataTypeFloat64;
}

class DataTypeUtils
{
	static public function dataTypeByteSize(dataType : DataType) : Int
	{
		switch(dataType)
		{
			case DataTypeInt8:
				return 1; 
			case DataTypeUInt8:
				return 1;
			case DataTypeInt16:
				return 2;
			case DataTypeUInt16:
				return 2;
			case DataTypeInt32:
				return 4;
			case DataTypeUInt32:
				return 4;
			case DataTypeFloat32:
				return 4;
            case DataTypeFloat64:
                return 8;
		}
		return 0;
	}
}