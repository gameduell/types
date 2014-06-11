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
        data.writeIntArray(array, DataTypeInt);

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

        assertEquals(1, dataInput.readInt(DataTypeUnsignedByte));
        assertEquals(2, dataInput.readInt(DataTypeUnsignedByte));
        assertEquals(3, dataInput.readInt(DataTypeUnsignedByte));
        assertEquals(-4, dataInput.readInt(DataTypeShort));
        assertEquals(5, dataInput.readInt(DataTypeUnsignedShort));

        var b0 = dataInput.readInt(DataTypeUnsignedByte);
        var b1 = dataInput.readInt(DataTypeUnsignedByte);
        var b2 = dataInput.readInt(DataTypeUnsignedByte);
        var int24Value = b0 | (b1 << 8) | (b2 << 16);
        if(int24Value & 0x800000 != 0)
            int24Value -= 0x1000000;
        assertEquals(-6, int24Value);

        b0 = dataInput.readInt(DataTypeUnsignedByte);
        b1 = dataInput.readInt(DataTypeUnsignedByte);
        b2 = dataInput.readInt(DataTypeUnsignedByte);

        int24Value = b0 | (b1 << 8) | (b2 << 16);
        assertEquals(7, int24Value);

        assertEquals(8, dataInput.readInt(DataTypeInt));
        assertTrue(TestHelper.nearlyEqual(9.123, dataInput.readFloat(DataTypeFloat)));
        assertTrue(TestHelper.nearlyEqual(10.123, dataInput.readFloat(DataTypeDouble)));
        assertEquals("a", dataInput.readString(1));
        assertEquals(11, dataInput.readInt(DataTypeUnsignedByte));
    }

    public function testInputStream() /// readLine, readUntil, readAll, readFullBytes still untested..
    {
        var data = new Data(32);
        var dataOutput = new DataOutputStream(data);
        dataOutput.writeInt(1, DataTypeUnsignedByte);
        dataOutput.writeInt(2, DataTypeUnsignedByte);
        dataOutput.writeInt(3, DataTypeUnsignedByte);
        dataOutput.writeInt(-4, DataTypeShort);
        dataOutput.writeInt(5, DataTypeShort);

        dataOutput.writeInt(-6, DataTypeUnsignedByte);
        dataOutput.writeInt(255, DataTypeUnsignedByte);
        dataOutput.writeInt(255, DataTypeUnsignedByte);

        /// 7 0 0 = 7
        dataOutput.writeInt(7, DataTypeUnsignedByte);
        dataOutput.writeInt(0, DataTypeUnsignedByte);
        dataOutput.writeInt(0, DataTypeUnsignedByte);

        dataOutput.writeInt(8, DataTypeInt);

        dataOutput.writeFloat(9.123, DataTypeFloat);

        dataOutput.writeFloat(10.123, DataTypeDouble);

        dataOutput.writeString("a");

        dataOutput.writeInt(11, DataTypeUnsignedByte);

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