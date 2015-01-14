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

import runloop.RunLoop;

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

        assertTrue(!inputStream.isOpen());
        assertTrue(!outputStream.isOpen());

        outputStream.open();
        inputStream.open();

        assertTrue(outputStream.isOpen());
        assertTrue(inputStream.isOpen());

        ///no data was written, so it should be 0
        assertEquals(0, inputStream.bytesAvailable);

        var dataToWrite = new Data(2);
        dataToWrite.writeInt(1, DataTypeInt16);
        outputStream.writeData(dataToWrite);
        assertEquals(2, inputStream.bytesAvailable);
    }

    public function testAppending()
    {
        var array = [1, 2, 3, 4, 5];
        var dataToWrite = new Data(array.length * 4);
        dataToWrite.writeIntArray(array, DataTypeInt32);

        var data = new Data(array.length * 4);
        var inputStream = new DataInputStream(data);
        var outputStream = new DataOutputStream(data, true);

        assertEquals(0, inputStream.bytesAvailable);

        outputStream.writeData(dataToWrite);

        assertEquals(array.length * 4, inputStream.bytesAvailable);

        data.offset = array.length * 4;
        outputStream.writeData(dataToWrite);

        assertEquals(array.length * 4 * 2, inputStream.bytesAvailable);

        data.offset = 0;
        assertEqualIntArray([1, 2, 3, 4, 5, 1, 2, 3, 4, 5], data.readIntArray(array.length * 2, DataTypeInt32));
    }

    public function testWritingAndReadingData()
    {
        var array = [1, 2, 3, 4, 5];
        var data = new Data(array.length * 4);

        var dataToWrite = new Data(array.length * 4);

        var outputStream = new DataOutputStream(data);
        outputStream.open();
        outputStream.writeData(dataToWrite);

        var inputStream = new DataInputStream(data);
        inputStream.open();
        var dataRead = new Data(array.length * 4);
        inputStream.readIntoData(dataRead);

        assertEqualIntArray([1, 2, 3, 4, 5], dataRead.readIntArray(array.length, DataTypeInt32));
    }

    public function testReadSkip()
    {
        var array = [1, 2, 3, 4, 5];
        var data = new Data(array.length * 4);
        data.writeIntArray(array, DataTypeInt32);

        var inputStream = new DataInputStream(data);
        inputStream.open();
        inputStream.skip(8);

        var dataToReadInto = new Data(4);
        inputStream.readIntoData(dataToReadInto);

        assertEquals(3, dataToReadInto.readInt(DataTypeInt32));
    }

    public function testCallbacks()
    {
        var array = [1, 2, 3, 4, 5];
        var dataToWrite = new Data(array.length * 4);
        dataToWrite.writeIntArray(array, DataTypeInt8);

        var dataToReceive = new Data(array.length * 4);

        var dataToWorkOn = new Data(array.length * 4);

        var outputStream = new DataOutputStream(dataToWorkOn);
        var inputStream = new DataInputStream(dataToWorkOn);

        var outputStreamOnOpenCalled: Bool = false;
        var outputStreamOnClosedCalled: Bool = false;
        var inputStreamOnOpenCalled: Bool = false;
        var inputStreamOnClosedCalled: Bool = false;
        var inputStreamOnEndOfStreamCalled: Bool = false;

        outputStream.onClose.add(function(s) outputStreamOnClosedCalled = true);
        outputStream.onOpen.add(function(s) outputStreamOnOpenCalled = true);

        inputStream.onClose.add(function(s) inputStreamOnClosedCalled = true);
        inputStream.onOpen.add(function(s) inputStreamOnOpenCalled = true);
        inputStream.onEndOfStream.add(function(s) inputStreamOnEndOfStreamCalled = true);

        assertAsyncStart("testCallbacks", 2);
        RunLoop.getMainLoop().queue(function() {
            assertAsyncTrue("testCallbacks", outputStreamOnOpenCalled);
            assertAsyncTrue("testCallbacks", outputStreamOnClosedCalled);
            assertAsyncTrue("testCallbacks", inputStreamOnOpenCalled);
            assertAsyncTrue("testCallbacks", inputStreamOnClosedCalled);
            assertAsyncTrue("testCallbacks", inputStreamOnEndOfStreamCalled);
            assertAsyncFinish("testCallbacks");
        }, PriorityASAP);

        outputStream.open();
        inputStream.open();

        outputStream.writeData(dataToWrite);
        inputStream.readIntoData(dataToReceive);

        outputStream.close();
        inputStream.close();
    }
}