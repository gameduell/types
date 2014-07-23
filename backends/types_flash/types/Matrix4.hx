package types;
import types.Data;

class Matrix4
{
    public var data(default, null) : Data;

    static private  var identity : Data;
    static private var dataSize:Int = 4;

    public function new() : Void{
        data = new Data(4*4*4);
    }

    public function setIdentity() : Void
    {
        if(identity == null)
        {
            identity = new Data(4*4*4);
            identity.offset = 0;
            identity.writeFloatArray(
                [
                1.0, 0.0, 0.0, 0.0,
                0.0, 1.0, 0.0, 0.0,
                0.0, 0.0, 1.0, 0.0,
                0.0, 0.0, 0.0, 1.0
                ]
                , DataTypeFloat32);
        }

        data.offset = 0;
        identity.offset = 0;
        data.writeData(identity);
    }

    public function setOrtho( x0 : Float, x1 : Float, y0 : Float, y1 : Float, zNear : Float, zFar : Float) : Void
    {
        var oldOffset = data.offset;

        var left:Float = x0;
        var right:Float = x1;
        var bottom:Float = y0;
        var top:Float = y1;

        var ral:Float = right + left;
        var rsl:Float = right - left;
        var tab:Float = top + bottom;
        var tsb:Float = top - bottom;
        var fan:Float = zFar + zNear;
        var fsn:Float = zFar - zNear;

        var m00:Float = 2.0 / rsl;
        var m01:Float = 0.0;
        var m02:Float = 0.0;
        var m03:Float = 0.0;
        var m04:Float = 0.0;
        var m05:Float = 2.0 / tsb;
        var m06:Float = 0.0;
        var m07:Float = 0.0;
        var m08:Float = 0.0;
        var m09:Float = 0.0;
        var m10:Float = -2.0 / fsn;
        var m11:Float = 0.0;
        var m12:Float = -ral / rsl;
        var m13:Float = -tab / tsb;
        var m14:Float = -fan / fsn;
        var m15:Float = 1.0;

        var counter:Int = 0;

        // Write Right Handed/Transposed

        data.offset = counter;
        data.writeFloat(m00,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m04,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m08,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m12,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m01,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m05,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m09,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m13,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m02,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m06,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m10,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m14,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m03,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m07,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m11,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m15,        DataTypeFloat32);

        data.offset = oldOffset;
    }

    public function set2D( posX : Float, posY : Float, scale : Float,rotation : Float) : Void
    {
        var oldOffset = data.offset;

        var theta = rotation * Math.PI / 180.0;
        var c = Math.cos(theta);
        var s = Math.sin(theta);

        var m00:Float = c * scale;
        var m01:Float = -s * scale;
        var m02:Float = 0.0;
        var m03:Float = 0.0;
        var m04:Float = s * scale;
        var m05:Float = c * scale;
        var m06:Float = 0.0;
        var m07:Float = 0.0;
        var m08:Float = 0.0;
        var m09:Float = 0.0;
        var m10:Float = 1.0;
        var m11:Float = 0.0;
        var m12:Float = posX;
        var m13:Float = posY;
        var m14:Float = 0.0;
        var m15:Float = 1.0;

        var counter:Int = 0;

        // Write Right Handed/Transposed

        data.offset = counter;
        data.writeFloat(m00,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m04,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m08,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m12,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m01,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m05,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m09,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m13,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m02,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m06,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m10,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m14,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m03,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m07,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m11,        DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(m15,        DataTypeFloat32);

        data.offset = oldOffset;
    }

    public function set(other : Matrix4) : Void {
        var prevOffset = data.offset;
        data.offset = 0;
        other.data.offset = 0;
        data.writeData(other.data);
        data.offset = prevOffset;
    }

    public function get(row : Int, col : Int) : Float{
        var oldOffset =  data.offset;
        data.offset = (row * 4 + col) * dataSize;
        var returnValue = data.readFloat(DataTypeFloat32);
        data.offset = oldOffset;
        return returnValue;
    }

    public function multiply(right : Matrix4) : Void{

        var oldOffset = data.offset;

        var counter:Int = 0;

        // Read Right

        right.data.offset = counter;
        var mR00:Float = right.data.readFloat(DataTypeFloat32);
        right.data.offset = dataSize * ++counter;
        var mR01:Float = right.data.readFloat(DataTypeFloat32);
        right.data.offset = dataSize * ++counter;
        var mR02:Float = right.data.readFloat(DataTypeFloat32);
        right.data.offset = dataSize * ++counter;
        var mR03:Float = right.data.readFloat(DataTypeFloat32);

        right.data.offset = dataSize * ++counter;
        var mR04:Float = right.data.readFloat(DataTypeFloat32);
        right.data.offset = dataSize * ++counter;
        var mR05:Float = right.data.readFloat(DataTypeFloat32);
        right.data.offset = dataSize * ++counter;
        var mR06:Float = right.data.readFloat(DataTypeFloat32);
        right.data.offset = dataSize * ++counter;
        var mR07:Float = right.data.readFloat(DataTypeFloat32);

        right.data.offset = dataSize * ++counter;
        var mR08:Float = right.data.readFloat(DataTypeFloat32);
        right.data.offset = dataSize * ++counter;
        var mR09:Float = right.data.readFloat(DataTypeFloat32);
        right.data.offset = dataSize * ++counter;
        var mR10:Float = right.data.readFloat(DataTypeFloat32);
        right.data.offset = dataSize * ++counter;
        var mR11:Float = right.data.readFloat(DataTypeFloat32);

        right.data.offset = dataSize * ++counter;
        var mR12:Float = right.data.readFloat(DataTypeFloat32);
        right.data.offset = dataSize * ++counter;
        var mR13:Float = right.data.readFloat(DataTypeFloat32);
        right.data.offset = dataSize * ++counter;
        var mR14:Float = right.data.readFloat(DataTypeFloat32);
        right.data.offset = dataSize * ++counter;
        var mR15:Float = right.data.readFloat(DataTypeFloat32);

        right.data.offset = 0;

        // Read Left
        counter = 0;

        data.offset = counter;
        var mL00:Float = data.readFloat(DataTypeFloat32);
        data.offset = dataSize * ++counter;
        var mL01:Float = data.readFloat(DataTypeFloat32);
        data.offset = dataSize * ++counter;
        var mL02:Float = data.readFloat(DataTypeFloat32);
        data.offset = dataSize * ++counter;
        var mL03:Float = data.readFloat(DataTypeFloat32);

        data.offset = dataSize * ++counter;
        var mL04:Float = data.readFloat(DataTypeFloat32);
        data.offset = dataSize * ++counter;
        var mL05:Float = data.readFloat(DataTypeFloat32);
        data.offset = dataSize * ++counter;
        var mL06:Float = data.readFloat(DataTypeFloat32);
        data.offset = dataSize * ++counter;
        var mL07:Float = data.readFloat(DataTypeFloat32);

        data.offset = dataSize * ++counter;
        var mL08:Float = data.readFloat(DataTypeFloat32);
        data.offset = dataSize * ++counter;
        var mL09:Float = data.readFloat(DataTypeFloat32);
        data.offset = dataSize * ++counter;
        var mL10:Float = data.readFloat(DataTypeFloat32);
        data.offset = dataSize * ++counter;
        var mL11:Float = data.readFloat(DataTypeFloat32);

        data.offset = dataSize * ++counter;
        var mL12:Float = data.readFloat(DataTypeFloat32);
        data.offset = dataSize * ++counter;
        var mL13:Float = data.readFloat(DataTypeFloat32);
        data.offset = dataSize * ++counter;
        var mL14:Float = data.readFloat(DataTypeFloat32);
        data.offset = dataSize * ++counter;
        var mL15:Float = data.readFloat(DataTypeFloat32);


        // Calculate

        var out00:Float = mL00 * mR00 + mL04 * mR01 + mL08 * mR02 + mL12 * mR03;
        var out04:Float = mL00 * mR04 + mL04 * mR05 + mL08 * mR06 + mL12 * mR07;
        var out08:Float = mL00 * mR08 + mL04 * mR09 + mL08 * mR10 + mL12 * mR11;
        var out12:Float = mL00 * mR12 + mL04 * mR13 + mL08 * mR14 + mL12 * mR15;

        var out01:Float = mL01 * mR00 + mL05 * mR01 + mL09 * mR02 + mL13 * mR03;
        var out05:Float = mL01 * mR04 + mL05 * mR05 + mL09 * mR06 + mL13 * mR07;
        var out09:Float = mL01 * mR08 + mL05 * mR09 + mL09 * mR10 + mL13 * mR11;
        var out13:Float = mL01 * mR12 + mL05 * mR13 + mL09 * mR14 + mL13 * mR15;

        var out02:Float = mL02 * mR00 + mL06 * mR01 + mL10 * mR02 + mL14 * mR03;
        var out06:Float = mL02 * mR04 + mL06 * mR05 + mL10 * mR06 + mL14 * mR07;
        var out10:Float = mL02 * mR08 + mL06 * mR09 + mL10 * mR10 + mL14 * mR11;
        var out14:Float = mL02 * mR12 + mL06 * mR13 + mL10 * mR14 + mL14 * mR15;

        var out03:Float = mL03 * mR00 + mL07 * mR01 + mL11 * mR02 + mL15 * mR03;
        var out07:Float = mL03 * mR04 + mL07 * mR05 + mL11 * mR06 + mL15 * mR07;
        var out11:Float = mL03 * mR08 + mL07 * mR09 + mL11 * mR10 + mL15 * mR11;
        var out15:Float = mL03 * mR12 + mL07 * mR13 + mL11 * mR14 + mL15 * mR15;


        // Write local
        counter = 0;

        data.offset = counter;
        data.writeFloat(out00, DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(out01, DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(out02, DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(out03, DataTypeFloat32);

        data.offset = dataSize * ++counter;
        data.writeFloat(out04, DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(out05, DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(out06, DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(out07, DataTypeFloat32);

        data.offset = dataSize * ++counter;
        data.writeFloat(out08, DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(out09, DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(out10, DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(out11, DataTypeFloat32);

        data.offset = dataSize * ++counter;
        data.writeFloat(out12, DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(out13, DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(out14, DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat(out15, DataTypeFloat32);

        data.offset = oldOffset;
    }

    public function toString() : String{
        return data.toString(DataTypeFloat32);
    }
}