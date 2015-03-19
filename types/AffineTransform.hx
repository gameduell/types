/*
 * Created by IntelliJ IDEA.
 * User: sott
 * Date: 08/05/14
 * Time: 16:34
 */

package types;

class AffineTransform
{
    /*
    [ a b x]
    [ c d y]
    [ 0 0 1]
    */
    public var a: Float = 0.0;  // m00
    public var b: Float = 0.0;  // m10
    public var c: Float = 0.0;  // m01
    public var d: Float = 0.0;  // m11
    public var tx: Float = 0.0; // m02
    public var ty: Float = 0.0; // m12

    public function new(): Void
    {
    }

    public function setIdentity(): Void
    {
        a = 1.0;
        b = 0.0;
        c = 0.0;
        d = 1.0;
        tx = 0.0;
        ty = 0.0;
    }

    public function set(other: AffineTransform): Void
    {
        a = other.a;
        b = other.b;
        c = other.c;
        d = other.d;
        tx = other.tx;
        ty = other.ty;
    }

    public function get(index: Int): Float
    {
        switch (index)
        {
            case 0: return a;
            case 1: return b;
            case 2: return c;
            case 3: return d;
            case 4: return tx;
            case 5: return ty;

            default: return 0.0;
        }
    }

    public function translate(_tx: Float, _ty: Float): Void
    {
        tx += a * _tx + b * _ty;
        ty += c * _tx + d * _ty;
    }

    public function scale(sx: Float, sy: Float): Void
    {
        a *= sx;
        b *= sy;
        c *= sx;
        d *= sy;
    }

    public function rotate(radians: Float): Void
    {
        var cos: Float = Math.cos(radians);
        var sin: Float = Math.sin(radians);

        var tA = a * cos  + c * sin;
        var tB = b * cos  + d * sin;
        var tC = a * -sin + c * cos;
        var tD = b * -sin + d * cos;

        a = tA;
        b = tB;
        c = tC;
        d = tD;
    }

    public function concat(right: AffineTransform): Void
    {
        var leftA: Float = a;
        var leftB: Float = b;
        var leftC: Float = c;
        var leftD: Float = d;
        var leftTx: Float = tx;
        var leftTy: Float = ty;

        a = leftA * right.a + leftB * right.c;
        b = leftA * right.b + leftB * right.d;
        c = leftC * right.a + leftD * right.c;
        d = leftC * right.b + leftD * right.d;
        tx = leftTx * right.a + leftTy * right.c + right.tx;
        ty = leftTx * right.b + leftTy * right.d + right.ty;
    }

    public function invert(): Void
    {
        var ta: Float = a;
        var tb: Float = b;
        var tc: Float = c;
        var td: Float = d;
        var ttx: Float = tx;
        var tty: Float = ty;

        var determinant: Float = 1.0 / (ta * td - tb * tc);

        a =  determinant * td;
        b = -determinant * tb;
        c = -determinant * tc;
        d =  determinant * ta;
        tx = determinant * (tc * tty - td * ttx);
        ty = determinant * (tb * ttx - ta * tty);
    }

    public function skew(skewX: Float, skewY: Float): Void
    {
        var tmp0: Float = a + skewX * c;
        var tmp1: Float = c + -skewY * a;

        a = tmp0;
        c = tmp1;

        tmp0 = b + skewX * d;
        tmp1 = d + -skewY * b;

        b = tmp0;
        d = tmp1;
    }

    public function setPositionRotationScale(posX: Float, posY: Float, radians: Float, scaleX: Float, scaleY: Float): Void
    {
        tx = posX;
        ty = posY;

        if (radians == 0.0)
        {
            a = scaleX;
            b = 0.0;
            c = 0.0;
            d = scaleY;
        }
        else
        {
            var cos: Float = Math.cos(radians);
            var sin: Float = Math.sin(radians);

            a =  cos * scaleX;
            b =  sin * scaleY;
            c = -sin * scaleX;
            d =  cos * scaleY;
        }
    }

    public function toString(): String
    {
        return "[" + a + ", " + b + ", " + c + ", " + d + ", " + tx + ", " + ty + "]";
    }
}
