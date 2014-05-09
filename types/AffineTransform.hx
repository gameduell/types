/*
 * Created by IntelliJ IDEA.
 * User: sott
 * Date: 08/05/14
 * Time: 16:34
 */

package types;

import types.Data;
import types.DataType;


class AffineTransform
{
    public var data(default, null) : Data;

    private static var identity : Data;
    private static var workingData : Data;

    public function new() : Void
    {
        data = new Data(6*4);

        if (workingData == null)
        {
            workingData = new Data(6*4);
        }
    }

    public function setIdentity() : Void
    {
        if(identity == null)
        {
            identity = new Data(6*4);//a   b    c    d    tx   ty
            identity.writeFloatArray([1.0, 0.0, 0.0, 1.0, 0.0, 0.0], DataTypeFloat);
        }
        data.offset = 0;
        identity.offset = 0;
        data.writeData(identity);
    }

    public function setValues(a:Float,b:Float,c:Float,d:Float,tx:Float,ty:Float) : Void
    {
        data.offset = 0 * 4;
        data.writeFloat( a , DataTypeFloat);   // a

        data.offset = 1 * 4;
        data.writeFloat( b , DataTypeFloat);   // b

        data.offset = 2 * 4;
        data.writeFloat( c , DataTypeFloat);   // c

        data.offset = 3 * 4;
        data.writeFloat( d , DataTypeFloat);   // d

        data.offset = 4 * 4;
        data.writeFloat(tx , DataTypeFloat);   // tx

        data.offset = 5 * 4;
        data.writeFloat(ty , DataTypeFloat);   // ty
    }

    public function set(other : AffineTransform) : Void
    {
        data.resetOffset();
        other.data.resetOffset();
        data.writeData(other.data);
    }

    public function get(index : Int) : Float
    {
        data.offset = index * 4;
        return data.readFloat(DataTypeFloat);
    }

    public function translate(tx:Float, ty:Float) : Void
    {
        var la:Float = get(0);
        var lb:Float = get(1);
        var lc:Float = get(2);
        var ld:Float = get(3);

        var ltx:Float = get(4);     // The offset is still at 4
        data.writeFloat(ltx +  la * tx  +  lc * ty, DataTypeFloat);

        var lty:Float = get(5);     // The offset is still at 5
        data.writeFloat(lty +  lb * tx  +  ld * ty, DataTypeFloat);
    }

    public function scale(sx:Float, sy:Float) : Void
    {
        workingData.offset = 0 * 4;
        workingData.writeFloat(get(0) * sx, DataTypeFloat);

        workingData.offset = 1 * 4;
        workingData.writeFloat(get(1) * sx, DataTypeFloat);

        workingData.offset = 2 * 4;
        workingData.writeFloat(get(2) * sy, DataTypeFloat);

        workingData.offset = 3 * 4;
        workingData.writeFloat(get(3) * sy, DataTypeFloat);

        workingData.offset = 0;
        workingData.offsetLength = 4 * 4;

        data.offset = 0;
        data.writeData(workingData);
    }

    public function rotate(angle:Float) : Void
    {
        var sine:Float = Math.sin(angle);
        var cosine:Float = Math.cos(angle);

        var a:Float = get(0);
        var b:Float = get(1);
        var c:Float = get(2);
        var d:Float = get(3);

        workingData.offset = 0 * 4;
        workingData.writeFloat(a * cosine + c * sine, DataTypeFloat);

        workingData.offset = 1 * 4;
        workingData.writeFloat(b * cosine + d * sine, DataTypeFloat);

        workingData.offset = 2 * 4;
        workingData.writeFloat(c * cosine - a * sine, DataTypeFloat);

        workingData.offset = 3 * 4;
        workingData.writeFloat(d * cosine - b * sine, DataTypeFloat);

        workingData.offset = 0;
        workingData.offsetLength = 4 * 4;

        data.offset = 0;
        data.writeData(workingData);
    }

    public function concat(right : AffineTransform) : Void
    {
        var leftA:Float = get(0);
        var leftB:Float = get(1);
        var leftC:Float = get(2);
        var leftD:Float = get(3);
        var leftTx:Float = get(4);
        var leftTy:Float = get(5);

        right.data.offset = 0 * 4;
        var rightA:Float = right.data.readFloat(DataTypeFloat);

        right.data.offset = 1 * 4;
        var rightB:Float = right.data.readFloat(DataTypeFloat);

        right.data.offset = 2 * 4;
        var rightC:Float = right.data.readFloat(DataTypeFloat);

        right.data.offset = 3 * 4;
        var rightD:Float = right.data.readFloat(DataTypeFloat);

        right.data.offset = 4 * 4;
        var rightTx:Float = right.data.readFloat(DataTypeFloat);

        right.data.offset = 5 * 4;
        var rightTy:Float = right.data.readFloat(DataTypeFloat);

        data.offset = 0 * 4;
        data.writeFloat( leftA * rightA + leftB * rightC , DataTypeFloat);   // a

        data.offset = 1 * 4;
        data.writeFloat( leftA * rightB + leftB * rightD , DataTypeFloat);   // b

        data.offset = 2 * 4;
        data.writeFloat( leftC * rightA + leftD * rightC , DataTypeFloat);   // c

        data.offset = 3 * 4;
        data.writeFloat( leftC * rightB + leftD * rightD , DataTypeFloat);   // d

        data.offset = 4 * 4;
        data.writeFloat( leftTx * rightA + leftTy * rightC + rightTx , DataTypeFloat);   // tx

        data.offset = 5 * 4;
        data.writeFloat( leftTx * rightB + leftTy * rightD + rightTy , DataTypeFloat);   // ty
    }

    public function invert() : Void
    {
        var a:Float = get(0);
        var b:Float = get(1);
        var c:Float = get(2);
        var d:Float = get(3);
        var tx:Float = get(4);
        var ty:Float = get(5);

        var determinant:Float = 1.0 / (a * d - b * c);

        data.offset = 0 * 4;
        data.writeFloat( determinant * d , DataTypeFloat);   // a

        data.offset = 1 * 4;
        data.writeFloat(-determinant * b , DataTypeFloat);   // b

        data.offset = 2 * 4;
        data.writeFloat(-determinant * c , DataTypeFloat);   // c

        data.offset = 3 * 4;
        data.writeFloat( determinant * a, DataTypeFloat);   // d

        data.offset = 4 * 4;
        data.writeFloat( determinant * (c * ty - d * tx), DataTypeFloat);   // tx

        data.offset = 5 * 4;
        data.writeFloat( determinant * (b * tx - a * ty), DataTypeFloat);   // ty
    }

    public function toString() : String
    {
        var output = "";
        output += "[";

        data.offset = 0;
        output += data.readFloat(DataTypeFloat);

        for(i in 1...6)
        {
            output += ", ";
            data.offset = i * 4;
            output += data.readFloat(DataTypeFloat);
        }

        output += "]";
        return output;
    }
}