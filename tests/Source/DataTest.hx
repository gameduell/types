

import types.Data;
import types.DataStringTools;

import types.DataType;

import TestHelper;

using types.DataStringTools;

class DataTest extends unittest.TestCase
{
    private function assertFloatArray(floatArray : Array<Float>, data : Data, dataType : DataType)
    {
        var failed = false;
        var prevOffset = data.offset;
        var currentOffset = prevOffset;
        for(i in 0...floatArray.length)
        {
            data.offset = currentOffset;
            var f = floatArray[i];
            var fInData = data.readFloat(dataType);
            if(!TestHelper.nearlyEqual(f, fInData))
            {
                failed = true;
                break;
            }
            currentOffset += DataTypeUtils.dataTypeByteSize(dataType);
        }
        data.offset = prevOffset;

        if(failed)
        {
            trace("Comparison Failed, expected: " + floatArray.toString() + " and got: " + data.toString(dataType));
            assertTrue(false);
        }
        assertTrue(true);
    }

    private function assertIntArray(intArray : Array<Int>, data : Data, dataType : DataType)
    {
        var failed = false;
        var prevOffset = data.offset;
        var currentOffset = prevOffset;
        for(i in 0...intArray.length)
        {
            data.offset = currentOffset;
            var int = intArray[i];
            var intInData = data.readInt(dataType);
            if(int != intInData)
            {
                failed = true;
                break;
            }
            currentOffset += DataTypeUtils.dataTypeByteSize(dataType);
        }
        data.offset = prevOffset;

        if(failed)
        {
            trace("Comparison Failed, expected: " + intArray.toString() + " and got: " + data.toString(dataType));
            assertTrue(false);
        }
        assertTrue(true);
    }
    
    public function testCreation()
    {
    	var data = new Data(4);
        assertTrue(data != null && data.allocedLength == 4);
    }

    public function testSettingAFloat()
    {
    	var data = new Data(4);
    	data.writeFloat(1.1, DataTypeFloat32);
        assertFloatArray([1.1], data, DataTypeFloat32);
    }

    public function testSettingUnsignedShort()
    {
    	var data = new Data(2);
    	data.writeInt(1, DataTypeUInt16);
        assertIntArray([1], data, DataTypeUInt16);

    }

    public function testSettingUnsignedByte()
    {
    	var data = new Data(1);
    	data.writeInt(1, DataTypeUInt8);
        assertIntArray([1], data, DataTypeUInt8);
    }

    public function testSettingDouble()
    {
        var data = new Data(8);
        data.writeFloat(1.01223, DataTypeFloat64);
        assertFloatArray([1.01223], data, DataTypeFloat64);
    }

    public function testSettingIntArray()
    {
    	var array = [1, 2, 3, 4, 5];
    	var data = new Data(array.length * 4);
    	data.writeIntArray(array, DataTypeInt32);

        assertIntArray([1, 2, 3, 4, 5], data, DataTypeInt32);
    }

    public function testSettingFloatArray()
    {
    	var array = [1.1, 2.1, 3.1, 4.1, 5.1];
    	var data = new Data(array.length * 4);
    	data.writeFloatArray(array, DataTypeFloat32);

        assertFloatArray([1.1, 2.1, 3.1, 4.1, 5.1], data, DataTypeFloat32);
    }

    public function testSettingData()
    {
    	var array = [1, 2, 3, 4, 5];
    	var data = new Data(array.length * 4);
    	data.writeIntArray(array, DataTypeInt32);

    	var array2 = [6, 7];
    	var data2 = new Data(array2.length * 4);
    	data2.writeIntArray(array2, DataTypeInt32);

    	data.writeData(data2);

        assertIntArray([6, 7, 3, 4, 5], data, DataTypeInt32);
    }

    public function testSettingValueWithOffset()
    {
    	var data = new Data(2 * 4);
    	data.writeInt(1, DataTypeInt32);
        data.offset = 4;
    	data.writeInt(2, DataTypeInt32);
        data.offset = 0;

        assertIntArray([1, 2], data, DataTypeInt32);
    }


    public function testSettingDataWithOffset()
    {
    	var array = [1, 2, 3, 4, 5];
    	var data = new Data(array.length * 4);
    	data.writeIntArray(array, DataTypeInt32);

    	var array2 = [6, 7];
    	var data2 = new Data(array2.length * 4);
    	data2.writeIntArray(array2, DataTypeInt32);

        data.offset = 8;
    	data.writeData(data2);
        data.offset = 0;

        assertIntArray([1, 2, 6, 7, 5], data, DataTypeInt32);
    }

    public function testSettingArrayWithOffset()
    {
    	var array = [1, 2, 3, 4, 5];
    	var data = new Data(array.length * 4);
    	data.writeIntArray(array, DataTypeInt32);

    	var array2 = [6, 7];
        data.offset = 8;
    	data.writeIntArray(array2, DataTypeInt32);
        data.offset = 0;

        assertIntArray([1, 2, 6, 7, 5], data, DataTypeInt32);
    }

    public function testDataStringTools()
    {
        var str = "Test String With 2 byte UTF8 character <†> and 4 byte UTF8 character <১>";
        assertTrue(str.sizeInBytes() == 76);
        
        var data = new Data(str.sizeInBytes());
        data.writeString(str);   

        var newStr = data.readString();
        assertTrue(str == newStr);
    }

    public function testResize()
    {
        var array = [1, 2, 3, 4, 5];
        var data = new Data((array.length - 1) * 4);
        data.resize((array.length) * 4);
        data.writeIntArray(array, DataTypeInt32);

        assertIntArray([1, 2, 3, 4, 5], data, DataTypeInt32);

    }

    ///missing testing offset with smaller types than int/float, and future big types like double
}