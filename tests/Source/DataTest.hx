
import types.Data;

import types.DataType;

import TestHelper;

using types.DataStringTools;

class DataTest extends haxe.unit.TestCase
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
            var fInData = data.getFloat(dataType);
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
            var intInData = data.getInt(dataType);
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
    	data.setFloat(1.1, DataTypeFloat);
        assertFloatArray([1.1], data, DataTypeFloat);
    }

    public function testSettingUnsignedShort()
    {
    	var data = new Data(2);
    	data.setInt(1, DataTypeUnsignedShort);
        assertIntArray([1], data, DataTypeUnsignedShort);

    }

    public function testSettingUnsignedByte()
    {
    	var data = new Data(1);
    	data.setInt(1, DataTypeUnsignedByte);
        assertIntArray([1], data, DataTypeUnsignedByte);
    }

    public function testSettingIntArray()
    {
    	var array = [1, 2, 3, 4, 5];
    	var data = new Data(array.length * 4);
    	data.setIntArray(array, DataTypeInt);

        assertIntArray([1, 2, 3, 4, 5], data, DataTypeInt);
    }

    public function testSettingFloatArray()
    {
    	var array = [1.1, 2.1, 3.1, 4.1, 5.1];
    	var data = new Data(array.length * 4);
    	data.setFloatArray(array, DataTypeFloat);

        assertFloatArray([1.1, 2.1, 3.1, 4.1, 5.1], data, DataTypeFloat);
    }

    public function testSettingData()
    {
    	var array = [1, 2, 3, 4, 5];
    	var data = new Data(array.length * 4);
    	data.setIntArray(array, DataTypeInt);

    	var array2 = [6, 7];
    	var data2 = new Data(array2.length * 4);
    	data2.setIntArray(array2, DataTypeInt);

    	data.setData(data2);

        assertIntArray([6, 7, 3, 4, 5], data, DataTypeInt);
    }

    public function testSettingValueWithOffset()
    {
    	var data = new Data(2 * 4);
    	data.setInt(1, DataTypeInt);
        data.offset = 4;
    	data.setInt(2, DataTypeInt);
        data.offset = 0;

        assertIntArray([1, 2], data, DataTypeInt);
    }


    public function testSettingDataWithOffset()
    {
    	var array = [1, 2, 3, 4, 5];
    	var data = new Data(array.length * 4);
    	data.setIntArray(array, DataTypeInt);

    	var array2 = [6, 7];
    	var data2 = new Data(array2.length * 4);
    	data2.setIntArray(array2, DataTypeInt);

        data.offset = 8;
    	data.setData(data2);
        data.offset = 0;

        assertIntArray([1, 2, 6, 7, 5], data, DataTypeInt);
    }

    public function testSettingArrayWithOffset()
    {
    	var array = [1, 2, 3, 4, 5];
    	var data = new Data(array.length * 4);
    	data.setIntArray(array, DataTypeInt);

    	var array2 = [6, 7];
        data.offset = 8;
    	data.setIntArray(array2, DataTypeInt);
        data.offset = 0;

        assertIntArray([1, 2, 6, 7, 5], data, DataTypeInt);
    }

    public function testDataStringTools()
    {
        var str = "Test String With 2 byte UTF8 character <†> and 4 byte UTF8 character <১>";
        assertTrue(str.sizeInBytes() == 76);
        
        var data = new Data(str.sizeInBytes());
        data.setString(str);   

        var newStr = data.createStringFromData();
        assertTrue(str == newStr);
        
    }

    public function testResize()
    {

        var array = [1, 2, 3, 4, 5];
        var data = new Data((array.length - 1) * 4);
        data.resize((array.length) * 4);
        data.setIntArray(array, DataTypeInt);

        assertIntArray([1, 2, 3, 4, 5], data, DataTypeInt);

    }

    ///missing testing offset with smaller types than int/float, and future big types like double
}