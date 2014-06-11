/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 10/06/14
 * Time: 12:16
 */
import types.haxeinterop.HaxeInputInteropStream;
import types.DataInputStream;
import haxe.io.BytesInput;
import types.DataOutputStream;
import haxe.io.BytesOutput;
import types.haxeinterop.HaxeOutputInteropStream;
import haxe.io.Bytes;
import types.Data;

import types.DataType;

import TestHelper;

using types.DataStringTools;
using types.haxeinterop.DataBytesTools;

class HaxeInteropTest extends haxe.unit.TestCase
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

    public function testDataBytesTools()
    {
        var array = [1, 2, 3, 4, 5];
        var data = new Data((array.length) * 4);
        data.writeIntArray(array, DataTypeInt32);

        var bytes = data.getBytes();
        assertEquals(1, bytes.get(0));
        assertEquals(2, bytes.get(4));
        assertEquals(3, bytes.get(8));
        assertEquals(4, bytes.get(12));
        assertEquals(5, bytes.get(16));
    }

    public function testOutputStream()
    {
        var data = new Data(32);
        var dataOutput = new DataOutputStream(data);
        var outputStream = new HaxeOutputInteropStream(dataOutput);

        var bytesToWrite = Bytes.alloc(1);

        bytesToWrite.set(0, 1);
        outputStream.write(bytesToWrite);

        bytesToWrite.set(0, 2);
        outputStream.writeFullBytes(bytesToWrite, 0, 1);

        outputStream.writeInt8(3);

        outputStream.writeInt16(-4);

        outputStream.writeUInt16(5);

        outputStream.writeInt24(-6);

        outputStream.writeUInt24(7);

        outputStream.writeInt32(8);

        outputStream.writeFloat(9.123);

        outputStream.writeDouble(10.123);

        outputStream.writeString("a");

        bytesToWrite.set(0, 11);

        var input = new BytesInput(bytesToWrite);
        outputStream.writeInput(input);

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

    public function testInputStream() /// readLine, readUntil, readAll, readFullBytes still untested..
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
        var haxeInput = new HaxeInputInteropStream(dataInput);

        assertEquals(1, haxeInput.readInt8());
        assertEquals(2, haxeInput.read(1).get(0));
        assertEquals(3, haxeInput.readInt8());
        assertEquals(-4, haxeInput.readInt16());
        assertEquals(5, haxeInput.readUInt16());

        assertEquals(-6, haxeInput.readInt24());
        assertEquals(7, haxeInput.readUInt24());

        assertEquals(8, haxeInput.readInt32());
        assertTrue(TestHelper.nearlyEqual(9.123, haxeInput.readFloat()));
        assertTrue(TestHelper.nearlyEqual(10.123, haxeInput.readDouble()));
        assertEquals("a", haxeInput.readString(1));
        assertEquals(11, haxeInput.readInt8());
    }

}