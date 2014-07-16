package types;

class Vector4
{
    public var data(default, null) : Data;
    public var dataOffset(default, null) : Int;

    public function new(_data : Data = null, _dataOffset : Int = 0) : Void
    {
        if(_data == null)
        {
            data = new Data(4*4);
        }
        else
        {
            data = _data;
        }

        dataOffset = _dataOffset;
    }

/// Vector Interface

    public var x(get, set) : Float;
    public var y(get, set) : Float;
    public var z(get, set) : Float;
    public var w(get, set) : Float;

    public function get_x() : Float
    {
        data.offset = dataOffset + 0;
        return data.readFloat(DataTypeFloat32);
    }

    public function set_x(x : Float) : Float
    {
        data.offset = dataOffset + 0;
        data.writeFloat(x, DataTypeFloat32);
        return x;
    }

    public function get_y() : Float
    {
        data.offset = dataOffset + 4;
        return data.readFloat(DataTypeFloat32);
    }

    public function set_y(y : Float) : Float
    {
        data.offset = dataOffset + 4;
        data.writeFloat(y, DataTypeFloat32);
        return y;
    }

    public function get_z() : Float
    {
        data.offset = dataOffset + 8;
        return data.readFloat(DataTypeFloat32);
    }

    public function set_z(z : Float) : Float
    {
        data.offset = dataOffset + 8;
        data.writeFloat(z, DataTypeFloat32);
        return z;
    }

    public function get_w() : Float
    {
        data.offset = dataOffset + 12;
        return data.readFloat(DataTypeFloat32);
    }

    public function set_w(w : Float) : Float
    {
        data.offset = dataOffset + 12;
        data.writeFloat(w, DataTypeFloat32);
        return w;
    }

/// Color Interface

    public var r(get, set) : Float;
    public var g(get, set) : Float;
    public var b(get, set) : Float;
    public var a(get, set) : Float;

    public function get_r() : Float
    {
        data.offset = dataOffset + 0;
        return data.readFloat(DataTypeFloat32);
    }

    public function set_r(r : Float) : Float
    {
        data.offset = dataOffset + 0;
        data.writeFloat(r, DataTypeFloat32);
        return r;
    }

    public function get_g() : Float
    {
        data.offset = dataOffset + 4;
        return data.readFloat(DataTypeFloat32);
    }

    public function set_g(g : Float) : Float
    {
        data.offset = dataOffset + 4;
        data.writeFloat(g, DataTypeFloat32);
        return g;
    }

    public function get_b() : Float
    {
        data.offset = dataOffset + 8;
        return data.readFloat(DataTypeFloat32);
    }

    public function set_b(b : Float) : Float
    {
        data.offset = dataOffset + 8;
        data.writeFloat(b, DataTypeFloat32);
        return b;
    }

    public function get_a() : Float
    {
        data.offset = dataOffset + 12;
        return data.readFloat(DataTypeFloat32);
    }

    public function set_a(a : Float) : Float
    {
        data.offset = dataOffset + 12;
        data.writeFloat(a, DataTypeFloat32);
        return a;
    }

/// Setters & Getters

    public function setXYZW(_x : Float, _y : Float, _z : Float, _w : Float)
    {
        x = _x;
        y = _y;
        z = _z;
        w = _w;
    }

    public function setRGBA(_r : Float, _g : Float, _b : Float, _a : Float)
    {
        r = _r;
        g = _g;
        b = _b;
        a = _a;
    }

    public function set(other : Vector4) : Void
    {
        data.offset = dataOffset;
        other.data.offset = other.dataOffset;
        other.data.offsetLength = 4 * 4;
        data.writeData(other.data);
    }

    public function get(index : Int) : Float
    {
        data.offset = dataOffset + index * 4;
        return data.readFloat(DataTypeFloat32);
    }

/// Math

    public function negate() : Void
    {
        x = -x;
        y = -y;
        z = -z;
        w = -w;
    }

    public function add(right : Vector4) : Void
    {
        x = x + right.x;
        y = y + right.y;
        z = z + right.z;
        w = w + right.w;
    }

    public function subtract(right : Vector4) : Void
    {
        x = x - right.x;
        y = y - right.y;
        z = z - right.z;
        w = w - right.w;
    }

    public function multiply(right : Vector4) : Void
    {
        x = x * right.x;
        y = y * right.y;
        z = z * right.z;
        w = w * right.w;
    }

    public function divide(right : Vector4) : Void
    {
        x = x / right.x;
        y = y / right.y;
        z = z / right.z;
        w = w / right.w;
    }

    public function addScalar(value : Float) : Void
    {
        x = x + value;
        y = y + value;
        z = z + value;
        w = w + value;
    }

    public function subtractScalar(value : Float) : Void
    {
        x = x - value;
        y = y - value;
        z = z - value;
        w = w - value;
    }

    public function multiplyScalar(value : Float) : Void
    {
        x = x * value;
        y = y * value;
        z = z * value;
        w = w * value;
    }

    public function divideScalar(value : Float) : Void
    {
        x = x / value;
        y = y / value;
        z = z / value;
        w = w / value;
    }

    public function normalize() : Void
    {
        var scale:Float = 1.0 / Vector4.length(this);
        multiplyScalar(scale);
    }

    public function lerp(start : Vector4, end : Vector4, t : Float) : Void
    {
        x = start.x + ((end.x - start.x) * t);
        y = start.y + ((end.y - start.y) * t);
        z = start.z + ((end.z - start.z) * t);
        w = start.w + ((end.w - start.w) * t);
    }

    public static function length(vector : Vector4) : Float
    {
        return Math.sqrt(Vector4.lengthSquared(vector));
    }

    public static function lengthSquared(vector : Vector4) : Float
    {
        return vector.x * vector.x + vector.y * vector.y + vector.z * vector.z + vector.w * vector.w;
    }

    private static var distanceVector4:Vector4;
    public static function distance(start : Vector4, end : Vector4) : Float
    {
        if (distanceVector4 == null)
            distanceVector4 = new Vector4();

        distanceVector4.set(end);
        distanceVector4.subtract(start);

        return Vector4.length(distanceVector4);
    }

    public function toString() : String
    {
        var output = "";
        output += "[";

        data.offset = dataOffset;
        output += data.readFloat(DataTypeFloat32);

        for(i in 1...4)
        {
            output += ", ";
            data.offset += 4;
            output += data.readFloat(DataTypeFloat32);
        }

        output += "]";
        return output;
    }

}