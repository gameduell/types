/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 06/06/14
 * Time: 18:53
 */
package ;

import haxe.macro.MacroStringTools;
import types.DataInputStream;
import types.DataOutputStream;
import types.Data;
import types.DataStringTools;

import types.DataType;

import TestHelper;

using types.DataStringTools;

class StreamTest extends unittest.TestCase
{
    private function assertEqualFloatArray(expectedArray : Array<Float>, actualArray : Array<Float>)
    {
        var failed = false;

        if(expectedArray.length != actualArray.length)
        {
            failed = true;
        } else {

            for(i in 0...expectedArray.length)
            {
                var expected = expectedArray[i];
                var actual = expectedArray[i];
                if(!TestHelper.nearlyEqual(expected, actual))
                {
                    failed = true;
                    break;
                }
            }
        }

        if(failed)
        {
            trace("Comparison Failed, expected: " + expectedArray.toString() + " and got: " + actualArray.toString());
            assertTrue(false);
        }
        assertTrue(true);
    }

    private function assertEqualIntArray(expectedArray : Array<Int>, actualArray : Array<Int>)
    {
        var failed = false;

        if(expectedArray.length != actualArray.length)
        {
            failed = true;
        } else {

            for(i in 0...expectedArray.length)
            {
                var expected = expectedArray[i];
                var actual = expectedArray[i];
                if(expected != actual)
                {
                    failed = true;
                    break;
                }
            }
        }

        if(failed)
        {
            trace("Comparison Failed, expected: " + expectedArray.toString() + " and got: " + actualArray.toString());
            assertTrue(false);
        }
        assertTrue(true);
    }


    public function testCreation()
    {
        var data = new Data(4);

        var outputStream = new DataOutputStream(data);

        var inputStream = new DataInputStream(data);

        assertTrue(outputStream.available());

        assertTrue(inputStream.available());
    }

    public function testWritingAndReadingAFloat()
    {
        var data = new Data(4);

        var outputStream = new DataOutputStream(data);
        outputStream.writeFloat(1.1, DataTypeFloat32);

        var inputStream = new DataInputStream(data);
        var val = inputStream.readFloat(DataTypeFloat32);

        assertTrue(TestHelper.nearlyEqual(1.1, val));
    }

    public function testWritingAndReadingUnsignedShort()
    {
        var data = new Data(2);

        var outputStream = new DataOutputStream(data);
        outputStream.writeInt(1, DataTypeUInt16);

        var inputStream = new DataInputStream(data);
        var val = inputStream.readInt(DataTypeUInt16);

        assertEquals(1, val);
    }

    public function testWritingAndReadingUnsignedByte()
    {
        var data = new Data(1);

        var outputStream = new DataOutputStream(data);
        outputStream.writeInt(1, DataTypeUInt8);

        var inputStream = new DataInputStream(data);
        var val = inputStream.readInt(DataTypeUInt8);

        assertEquals(1, val);
    }

    public function testWritingAndReadingIntArray()
    {
        var array = [1, 2, 3, 4, 5];
        var data = new Data(array.length * 4);

        var outputStream = new DataOutputStream(data);
        outputStream.writeIntArray(array, DataTypeInt32);

        var inputStream = new DataInputStream(data);

        assertEqualIntArray([1, 2, 3, 4, 5], inputStream.readIntArray(5, DataTypeInt32));
    }

    public function testWritingAndReadingFloatArray()
    {
        var array = [1.1, 2.1, 3.1, 4.1, 5.1];
        var data = new Data(array.length * 4);

        var outputStream = new DataOutputStream(data);
        outputStream.writeFloatArray(array, DataTypeFloat32);

        var inputStream = new DataInputStream(data);

        assertEqualFloatArray([1.1, 2.1, 3.1, 4.1, 5.1], inputStream.readFloatArray(5, DataTypeFloat32));
    }

    public function testWritingAndReadingData()
    {
        var array = [1, 2, 3, 4, 5];
        var data = new Data(array.length * 4);

        var dataToWrite = new Data(array.length * 4);

        var outputStream = new DataOutputStream(data);
        outputStream.writeData(dataToWrite);

        var inputStream = new DataInputStream(data);
        var dataRead = new Data(array.length * 4);
        inputStream.readIntoData(dataRead);

        assertEqualIntArray([1, 2, 3, 4, 5], dataRead.readIntArray(array.length, DataTypeInt32));
    }

    public function testWritingAndReadingValuesInSucession()
    {
        var data = new Data(4 * 2);

        var outputStream = new DataOutputStream(data);
        outputStream.writeInt(1, DataTypeInt32);
        outputStream.writeInt(2, DataTypeInt32);

        var inputStream = new DataInputStream(data);
        var val1 = inputStream.readInt(DataTypeInt32);
        var val2 = inputStream.readInt(DataTypeInt32);

        assertEquals(1, val1);
        assertEquals(2, val2);
    }


    public function testReadSkip()
    {
        var array = [1, 2, 3, 4, 5];
        var data = new Data(array.length * 4);
        data.writeIntArray(array, DataTypeInt32);

        var inputStream = new DataInputStream(data);
        inputStream.skip(8);

        var val = inputStream.readInt(DataTypeInt32);

        assertEquals(3, val);
    }

    public function testReadAll()
    {
        var array = [1, 2, 3, 4, 5];
        var data = new Data(array.length * 4);
        data.writeIntArray(array, DataTypeInt32);

        var inputStream = new DataInputStream(data);
        var newData = inputStream.readAll();

        assertEqualIntArray([1, 2, 3, 4, 5], newData.readIntArray(array.length, DataTypeInt32));
    }

    public function testAllPossibleDataTypes()
    {
        var data = new Data(32);
        var dataOutput = new DataOutputStream(data);
        dataOutput.writeInt(1, DataTypeUInt8);
        dataOutput.writeInt(2, DataTypeUInt8);
        dataOutput.writeInt(3, DataTypeUInt8);
        dataOutput.writeInt(-4, DataTypeInt16);
        dataOutput.writeInt(5, DataTypeInt16);

        dataOutput.writeInt(-6, DataTypeUInt8);
        dataOutput.writeInt(255, DataTypeUInt8);
        dataOutput.writeInt(255, DataTypeUInt8);

        /// 7 0 0 = 7
        dataOutput.writeInt(7, DataTypeUInt8);
        dataOutput.writeInt(0, DataTypeUInt8);
        dataOutput.writeInt(0, DataTypeUInt8);

        dataOutput.writeInt(8, DataTypeInt32);

        dataOutput.writeFloat(9.123, DataTypeFloat32);

        dataOutput.writeFloat(10.123, DataTypeFloat64);

        dataOutput.writeString("a");

        dataOutput.writeInt(11, DataTypeUInt8);

        var dataInput = new DataInputStream(data);

        assertEquals(1, dataInput.readInt(DataTypeUInt8));
        assertEquals(2, dataInput.readInt(DataTypeUInt8));
        assertEquals(3, dataInput.readInt(DataTypeUInt8));
        assertEquals(-4, dataInput.readInt(DataTypeInt16));
        assertEquals(5, dataInput.readInt(DataTypeInt16));

        var b0 = dataInput.readInt(DataTypeUInt8);
        var b1 = dataInput.readInt(DataTypeUInt8);
        var b2 = dataInput.readInt(DataTypeUInt8);
        var int24Value = b0 | (b1 << 8) | (b2 << 16);
        if(int24Value & 0x800000 != 0)
            int24Value -= 0x1000000;
        assertEquals(-6, int24Value);

        b0 = dataInput.readInt(DataTypeUInt8);
        b1 = dataInput.readInt(DataTypeUInt8);
        b2 = dataInput.readInt(DataTypeUInt8);

        int24Value = b0 | (b1 << 8) | (b2 << 16);
        assertEquals(7, int24Value);

        assertEquals(8, dataInput.readInt(DataTypeInt32));
        assertTrue(TestHelper.nearlyEqual(9.123, dataInput.readFloat(DataTypeFloat32)));
        assertTrue(TestHelper.nearlyEqual(10.123, dataInput.readFloat(DataTypeFloat64)));
        assertEquals("a", dataInput.readString(1));
        assertEquals(11, dataInput.readInt(DataTypeUInt8));
    }

    public function testString()
    {
        var str = "Test String With 2 byte UTF8 character <†> and 4 byte UTF8 character <১>";

        var data = new Data(str.sizeInBytes());

        var outputStream = new DataOutputStream(data);
        outputStream.writeString(str);

        var inputStream = new DataInputStream(data);
        var readString = inputStream.readString(str.sizeInBytes());

        assertEquals(str, readString);
    }

}