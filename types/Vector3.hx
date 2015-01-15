package types;

import types.Data;

class Vector3
{
    public var data(default, null): Data;
    public var dataOffset(default, null): Int;

/// Vector Interface

    public var x(get, set): Float;
    public var y(get, set): Float;
    public var z(get, set): Float;

/// Color Interface

    public var r(get, set): Float;
    public var g(get, set): Float;
    public var b(get, set): Float;

    public function new(_data: Data = null, _dataOffset: Int = 0): Void
    {
        if(_data == null)
        {
            data = new Data(3*4);
        }
        else
        {
            data = _data;
        }

        dataOffset = _dataOffset;
    }

    public function get_x(): Float
    {
        data.offset = dataOffset + 0;
        return data.readFloat(DataTypeFloat32);
    }

    public function set_x(value: Float): Float
    {
        data.offset = dataOffset + 0;
        data.writeFloat(value, DataTypeFloat32);
        return value;
    }

    public function get_y(): Float
    {
        data.offset = dataOffset + 4;
        return data.readFloat(DataTypeFloat32);
    }

    public function set_y(value: Float): Float
    {
        data.offset = dataOffset + 4;
        data.writeFloat(value, DataTypeFloat32);
        return value;
    }

    public function get_z(): Float
    {
        data.offset = dataOffset + 8;
        return data.readFloat(DataTypeFloat32);
    }

    public function set_z(value: Float): Float
    {
        data.offset = dataOffset + 8;
        data.writeFloat(value, DataTypeFloat32);
        return value;
    }


    public function get_r(): Float
    {
        data.offset = dataOffset + 0;
        return data.readFloat(DataTypeFloat32);
    }

    public function set_r(value: Float): Float
    {
        data.offset = dataOffset + 0;
        data.writeFloat(value, DataTypeFloat32);
        return value;
    }

    public function get_g(): Float
    {
        data.offset = dataOffset + 4;
        return data.readFloat(DataTypeFloat32);
    }

    public function set_g(value: Float): Float
    {
        data.offset = dataOffset + 4;
        data.writeFloat(value, DataTypeFloat32);
        return value;
    }

    public function get_b(): Float
    {
        data.offset = dataOffset + 8;
        return data.readFloat(DataTypeFloat32);
    }

    public function set_b(value: Float): Float
    {
        data.offset = dataOffset + 8;
        data.writeFloat(value, DataTypeFloat32);
        return value;
    }

/// Setters & Getters

    public function setXYZ(x: Float, y: Float, z: Float): Void
    {
        set_x(x);
        set_y(y);
        set_z(z);
    }

    public function setRGB(r: Float, g: Float, b: Float): Void
    {
        set_r(r);
        set_g(g);
        set_b(b);
    }

    public function set(other: Vector3): Void
    {
        data.offset = dataOffset;
        other.data.offset = other.dataOffset;
        other.data.offsetLength = 3 * 4;
        data.writeData(other.data);
    }

    public function get(index: Int): Float
    {
        data.offset = dataOffset + index * 4;
        return data.readFloat(DataTypeFloat32);
    }

/// Math

    public function negate(): Void
    {
        x = -x;
        y = -y;
        z = -z;
    }

    public function add(right: Vector3): Void
    {
        x = x + right.x;
        y = y + right.y;
        z = z + right.z;
    }

    public function subtract(right: Vector3): Void
    {
        x = x - right.x;
        y = y - right.y;
        z = z - right.z;
    }

    public function multiply(right: Vector3): Void
    {
        x = x * right.x;
        y = y * right.y;
        z = z * right.z;
    }

    public function divide(right: Vector3): Void
    {
        x = x / right.x;
        y = y / right.y;
        z = z / right.z;
    }

    public function addScalar(value: Float): Void
    {
        x = x + value;
        y = y + value;
        z = z + value;
    }

    public function subtractScalar(value: Float): Void
    {
        x = x - value;
        y = y - value;
        z = z - value;
    }

    public function multiplyScalar(value: Float): Void
    {
        x = x * value;
        y = y * value;
        z = z * value;
    }

    public function divideScalar(value: Float): Void
    {
        x = x / value;
        y = y / value;
        z = z / value;
    }

    public function normalize(): Void
    {
        var scale:Float = 1.0 / Vector3.length(this);
        multiplyScalar(scale);
    }

    public function lerp(start: Vector3, end: Vector3, t: Float): Void
    {
        x = start.x + ((end.x - start.x) * t);
        y = start.y + ((end.y - start.y) * t);
        z = start.z + ((end.z - start.z) * t);
    }

    public static function length(vector: Vector3): Float
    {
        return Math.sqrt(Vector3.lengthSquared(vector));
    }

    public static function lengthSquared(vector: Vector3): Float
    {
        return vector.x * vector.x + vector.y * vector.y + vector.z * vector.z;
    }

    private static var distanceVector3: Vector3 = new Vector3();

    public static function distance(start: Vector3, end: Vector3): Float
    {
        distanceVector3.set(end);
        distanceVector3.subtract(start);

        return Vector3.length(distanceVector3);
    }

    public function toString() : String
    {
        var output = "";
        output += "[";

        data.offset = dataOffset;
        output += data.readFloat(DataTypeFloat32);

        for(i in 1...3)
        {
            output += ", ";
            data.offset += 4;
            output += data.readFloat(DataTypeFloat32);
        }

        output += "]";
        return output;
    }

}
