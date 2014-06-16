package types;
import types.Data;

class Matrix4
{
    public var data(default, null) : Data;

    private static var identity : Data;
    private var dataSize:Int = 4;
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
        var ral:Float = x1 + x0;
        var rsl:Float = x1 - x0;
        var tab:Float = y1 + y0;
        var tsb:Float = y1 - y0;
        var fan:Float = zFar + zNear;
        var fsn:Float = zFar - zNear;
        var counter:Int = 0;

        data.offset = counter;
        data.writeFloat(2.0 / rsl, DataTypeFloat32);       //0
        data.offset = dataSize * ++counter;
        data.writeFloat(0.0, DataTypeFloat32);             //1
        data.offset = dataSize * ++counter;
        data.writeFloat(0.0, DataTypeFloat32);             //2
        data.offset = dataSize * ++counter;
        data.writeFloat(0.0, DataTypeFloat32);             //3
        data.offset = dataSize * ++counter;
        data.writeFloat(0.0, DataTypeFloat32);             //4
        data.offset = dataSize * ++counter;
        data.writeFloat(2.0 / tsb, DataTypeFloat32);       //5
        data.offset = dataSize * ++counter;
        data.writeFloat(0.0, DataTypeFloat32);             //6
        data.offset = dataSize * ++counter;
        data.writeFloat(0.0, DataTypeFloat32);             //7
        data.offset = dataSize * ++counter;
        data.writeFloat(0.0, DataTypeFloat32);             //8
        data.offset = dataSize * ++counter;
        data.writeFloat(0.0, DataTypeFloat32);             //9
        data.offset = dataSize * ++counter;
        data.writeFloat(-2.0 / fsn, DataTypeFloat32);      //10
        data.offset = dataSize * ++counter;
        data.writeFloat(0.0, DataTypeFloat32);             //11
        data.offset = dataSize * ++counter;
        data.writeFloat(-ral / rsl, DataTypeFloat32);      //12
        data.offset = dataSize * ++counter;
        data.writeFloat(-tab / tsb, DataTypeFloat32);      //13
        data.offset = dataSize * ++counter;
        data.writeFloat(-fan / fsn, DataTypeFloat32);      //14
        data.offset = dataSize * ++counter;
        data.writeFloat(1.0, DataTypeFloat32);             //15

        data.offset = oldOffset;
    }

    public function set2D( posX : Float, posY : Float, scale : Float,rotation : Float) : Void {
        var oldOffset = data.offset;
        var theta = rotation * Math.PI / 180.0;
        var c = Math.cos(theta);
        var s = Math.sin(theta);
        var counter:Int = 0;

        data.offset = counter;
        data.writeFloat( c * scale,     DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat( -s * scale,    DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat( 0.0,           DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat( 0.0,           DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat( s * scale,     DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat( c * scale,     DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat( 0.0,           DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat( 0.0,           DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat( 0.0,           DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat( 0.0,           DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat( 1.0,           DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat( 0.0,           DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat( posX,          DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat( posY,          DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat( 0.0,           DataTypeFloat32);
        data.offset = dataSize * ++counter;
        data.writeFloat( 1.0,           DataTypeFloat32);

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
        var a = data;
        var b = right.data;
        var out = data;
        var counter:Int = 0;
        a.offset = counter;

        var a00 = a.readFloat(DataTypeFloat32);
        a.offset = dataSize * ++counter;
        var a01 = a.readFloat(DataTypeFloat32);
        a.offset = dataSize * ++counter;
        var a02 = a.readFloat(DataTypeFloat32);
        a.offset = dataSize * ++counter;
        var a03 = a.readFloat(DataTypeFloat32);
        a.offset = dataSize * ++counter;
        var a10 = a.readFloat(DataTypeFloat32);
        a.offset = dataSize * ++counter;
        var a11 = a.readFloat(DataTypeFloat32);
        a.offset = dataSize * ++counter;
        var a12 = a.readFloat(DataTypeFloat32);
        a.offset = dataSize * ++counter;
        var a13 = a.readFloat(DataTypeFloat32);
        a.offset = dataSize * ++counter;
        var a20 = a.readFloat(DataTypeFloat32);
        a.offset = dataSize * ++counter;
        var a21 = a.readFloat(DataTypeFloat32);
        a.offset = dataSize * ++counter;
        var a22 = a.readFloat(DataTypeFloat32);
        a.offset = dataSize * ++counter;
        var a23 = a.readFloat(DataTypeFloat32);
        a.offset = dataSize * ++counter;
        var a30 = a.readFloat(DataTypeFloat32);
        a.offset = dataSize * ++counter;
        var a31 = a.readFloat(DataTypeFloat32);
        a.offset = dataSize * ++counter;
        var a32 = a.readFloat(DataTypeFloat32);
        a.offset = dataSize * ++counter;
        var a33 = a.readFloat(DataTypeFloat32);

        counter = 0;
        b.offset = counter * dataSize;
        // Cache only the current line of the second matrix
        var b0 = b.readFloat(DataTypeFloat32);
        b.offset = dataSize * ++counter;
        var b1 = b.readFloat(DataTypeFloat32);
        b.offset = dataSize * ++counter;
        var b2 = b.readFloat(DataTypeFloat32);
        b.offset = dataSize * ++counter;
        var b3 = b.readFloat(DataTypeFloat32);

        counter = 0;
        out.offset = counter * dataSize;

        out.writeFloat(b0*a00 + b1*a10 + b2*a20 + b3*a30,DataTypeFloat32);
        out.offset = dataSize * ++counter;
        out.writeFloat(b0*a01 + b1*a11 + b2*a21 + b3*a31,DataTypeFloat32);
        out.offset = dataSize * ++counter;
        out.writeFloat(b0*a02 + b1*a12 + b2*a22 + b3*a32,DataTypeFloat32);
        out.offset = dataSize * ++counter;
        out.writeFloat(b0*a03 + b1*a13 + b2*a23 + b3*a33,DataTypeFloat32);

        b.offset = dataSize * ++counter;

        b0 = b.readFloat(DataTypeFloat32);
        b.offset = dataSize * ++counter;
        b1 = b.readFloat(DataTypeFloat32);
        b.offset = dataSize * ++counter;
        b2 = b.readFloat(DataTypeFloat32);
        b.offset = dataSize * ++counter;
        b3 = b.readFloat(DataTypeFloat32);

        counter = 4;
        out.offset = counter * dataSize;

        out.writeFloat(b0*a00 + b1*a10 + b2*a20 + b3*a30,DataTypeFloat32);
        out.offset = dataSize * ++counter;
        out.writeFloat(b0*a01 + b1*a11 + b2*a21 + b3*a31,DataTypeFloat32);
        out.offset = dataSize * ++counter;
        out.writeFloat(b0*a02 + b1*a12 + b2*a22 + b3*a32,DataTypeFloat32);
        out.offset = dataSize * ++counter;
        out.writeFloat(b0*a03 + b1*a13 + b2*a23 + b3*a33,DataTypeFloat32);

        b.offset = dataSize * ++counter;

        b0 = b.readFloat(DataTypeFloat32);
        b.offset = dataSize * ++counter;
        b1 = b.readFloat(DataTypeFloat32);
        b.offset = dataSize * ++counter;
        b2 = b.readFloat(DataTypeFloat32);
        b.offset = dataSize * ++counter;
        b3 = b.readFloat(DataTypeFloat32);

        counter = 8;
        out.offset = counter * dataSize;

        out.writeFloat(b0*a00 + b1*a10 + b2*a20 + b3*a30,DataTypeFloat32);
        out.offset = dataSize * ++counter;
        out.writeFloat(b0*a01 + b1*a11 + b2*a21 + b3*a31,DataTypeFloat32);
        out.offset = dataSize * ++counter;
        out.writeFloat(b0*a02 + b1*a12 + b2*a22 + b3*a32,DataTypeFloat32);
        out.offset = dataSize * ++counter;
        out.writeFloat(b0*a03 + b1*a13 + b2*a23 + b3*a33,DataTypeFloat32);

        b.offset = dataSize * ++counter;

        b0 = b.readFloat(DataTypeFloat32);
        b.offset = dataSize * ++counter;
        b1 = b.readFloat(DataTypeFloat32);
        b.offset = dataSize * ++counter;
        b2 = b.readFloat(DataTypeFloat32);
        b.offset = dataSize * ++counter;
        b3 = b.readFloat(DataTypeFloat32);

        counter = 12;
        out.offset = counter * dataSize;

        out.writeFloat(b0*a00 + b1*a10 + b2*a20 + b3*a30,DataTypeFloat32);
        out.offset = dataSize * ++counter;
        out.writeFloat(b0*a01 + b1*a11 + b2*a21 + b3*a31,DataTypeFloat32);
        out.offset = dataSize * ++counter;
        out.writeFloat(b0*a02 + b1*a12 + b2*a22 + b3*a32,DataTypeFloat32);
        out.offset = dataSize * ++counter;
        out.writeFloat(b0*a03 + b1*a13 + b2*a23 + b3*a33,DataTypeFloat32);

        b.offset = 0;
        data.offset = oldOffset;
    }

    public function toString() : String{
        return data.toString(DataTypeFloat32);
    }
}