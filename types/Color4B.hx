/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 27/05/14
 * Time: 10:09
 */
package types;

import types.Data;
import types.DataType;

class Color4B
{
    public var data(default, default) : Data;
    public var dataOffset : Int;

    public function new(_data : Data = null, _dataOffset : Int = 0) : Void
    {
        if(_data == null)
        {
            data = new Data(4);
        }

        dataOffset = _dataOffset;
    }

    public var r(get, set) : Int;

    public function get_r() : Int
    {
        data.offset = dataOffset + 0;
        return data.readInt(DataTypeUnsignedByte);
    }

    public function set_r(r : Int) : Int
    {
        data.offset = dataOffset + 0;
        data.writeInt(r, DataTypeUnsignedByte);
        return r;
    }

    public var g(get, set) : Int;

    public function get_g() : Int
    {
        data.offset = dataOffset + 1;
        return data.readInt(DataTypeUnsignedByte);
    }

    public function set_g(g : Int) : Int
    {
        data.offset = dataOffset + 1;
        data.writeInt(g, DataTypeUnsignedByte);
        return g;
    }

    public var b(get, set) : Int;

    public function get_b() : Int
    {
        data.offset = dataOffset + 2;
        return data.readInt(DataTypeUnsignedByte);
    }

    public function set_b(b : Int) : Int
    {
        data.offset = dataOffset + 2;
        data.writeInt(b, DataTypeUnsignedByte);
        return b;
    }

    public var a(get, set) : Int;

    public function get_a() : Int
    {
        data.offset = dataOffset + 3;
        return data.readInt(DataTypeUnsignedByte);
    }

    public function set_a(a : Int) : Int
    {
        data.offset = dataOffset + 3;
        data.writeInt(a, DataTypeUnsignedByte);
        return a;
    }

    /// Helper Method
    public function setRGBA(_r : Int, _g : Int, _b : Int, _a : Int)
    {
        r = _r;
        g = _g;
        b = _b;
        a = _a;
    }

    public function toString() : String
    {
        var output = "";
        output += "[";

        data.offset = dataOffset;
        output += data.readInt(DataTypeUnsignedByte);

        for(i in 1...4)
        {
            output += ", ";
            data.offset += 1;
            output += data.readInt(DataTypeUnsignedByte);
        }

        output += "]";
        return output;
    }


}