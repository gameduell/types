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

class StreamTest extends haxe.unit.TestCase
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
        outputStream.writeFloat(1.1, DataTypeFloat);

        var inputStream = new DataInputStream(data);
        var val = inputStream.readFloat(DataTypeFloat);

        assertTrue(TestHelper.nearlyEqual(1.1, val));
    }

    public function testWritingAndReadingUnsignedShort()
    {
        var data = new Data(2);

        var outputStream = new DataOutputStream(data);
        outputStream.writeInt(1, DataTypeUnsignedShort);

        var inputStream = new DataInputStream(data);
        var val = inputStream.readInt(DataTypeUnsignedShort);

        assertEquals(1, val);
    }

    public function testWritingAndReadingUnsignedByte()
    {
        var data = new Data(1);

        var outputStream = new DataOutputStream(data);
        outputStream.writeInt(1, DataTypeUnsignedByte);

        var inputStream = new DataInputStream(data);
        var val = inputStream.readInt(DataTypeUnsignedByte);

        assertEquals(1, val);
    }

    public function testWritingAndReadingIntArray()
    {
        var array = [1, 2, 3, 4, 5];
        var data = new Data(array.length * 4);

        var outputStream = new DataOutputStream(data);
        outputStream.writeIntArray(array, DataTypeInt);

        var inputStream = new DataInputStream(data);

        assertEqualIntArray([1, 2, 3, 4, 5], inputStream.readIntArray(5, DataTypeInt));
    }

    public function testWritingAndReadingFloatArray()
    {
        var array = [1.1, 2.1, 3.1, 4.1, 5.1];
        var data = new Data(array.length * 4);

        var outputStream = new DataOutputStream(data);
        outputStream.writeFloatArray(array, DataTypeFloat);

        var inputStream = new DataInputStream(data);

        assertEqualFloatArray([1.1, 2.1, 3.1, 4.1, 5.1], inputStream.readFloatArray(5, DataTypeFloat));
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

        assertEqualIntArray([1, 2, 3, 4, 5], dataRead.readIntArray(array.length, DataTypeInt));
    }

    public function testWritingAndReadingValuesInSucession()
    {
        var data = new Data(4 * 2);

        var outputStream = new DataOutputStream(data);
        outputStream.writeInt(1, DataTypeInt);
        outputStream.writeInt(2, DataTypeInt);

        var inputStream = new DataInputStream(data);
        var val1 = inputStream.readInt(DataTypeInt);
        var val2 = inputStream.readInt(DataTypeInt);

        assertEquals(1, val1);
        assertEquals(2, val2);
    }


    public function testReadSkip()
    {
        var array = [1, 2, 3, 4, 5];
        var data = new Data(array.length * 4);
        data.writeIntArray(array, DataTypeInt);

        var inputStream = new DataInputStream(data);
        inputStream.skip(8);

        var val = inputStream.readInt(DataTypeInt);

        assertEquals(3, val);
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