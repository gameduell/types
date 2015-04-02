package types;

class Matrix3
{
    /* Column major [m00, m01, m02, m10, m11, m12, m20, m21, m22]
    [m00 m10 m20]
    [m01 m11 m21]
    [m02 m12 m22]
    */

    public var m00: Float = 1.0;
    public var m01: Float = 0.0;
    public var m02: Float = 0.0;

    public var m10: Float = 0.0;
    public var m11: Float = 1.0;
    public var m12: Float = 0.0;

    public var m20: Float = 0.0;
    public var m21: Float = 0.0;
    public var m22: Float = 1.0;

    public function new()
    {
    }

    public function setIdentity(): Void
    {
        m00 = 1.0;
        m01 = 0.0;
        m02 = 0.0;

        m10 = 0.0;
        m11 = 1.0;
        m12 = 0.0;

        m20 = 0.0;
        m21 = 0.0;
        m22 = 1.0;
    }

    public function set(other: Matrix3): Void
    {
        m00 = other.m00;
        m01 = other.m01;
        m02 = other.m02;

        m10 = other.m10;
        m11 = other.m11;
        m12 = other.m12;

        m20 = other.m20;
        m21 = other.m21;
        m22 = other.m22;
    }

    public function multiply(other: Matrix3): Void
    {
        var tmp00 = m00 * other.m00 + m01 * other.m10 + m02 * other.m20;
        var tmp01 = m00 * other.m01 + m01 * other.m11 + m02 * other.m21;
        var tmp02 = m00 * other.m02 + m01 * other.m12 + m02 * other.m22;

        var tmp10 = m10 * other.m00 + m11 * other.m10 + m12 * other.m20;
        var tmp11 = m10 * other.m01 + m11 * other.m11 + m12 * other.m21;
        var tmp12 = m10 * other.m02 + m11 * other.m12 + m12 * other.m22;

        var tmp20 = m20 * other.m00 + m21 * other.m10 + m22 * other.m20;
        var tmp21 = m20 * other.m01 + m21 * other.m11 + m22 * other.m21;
        var tmp22 = m20 * other.m02 + m21 * other.m12 + m22 * other.m22;

        m00 = tmp00;
        m01 = tmp01;
        m02 = tmp02;

        m10 = tmp10;
        m11 = tmp11;
        m12 = tmp12;

        m20 = tmp20;
        m21 = tmp21;
        m22 = tmp22;
    }

    public function preMultiply(other: Matrix3): Void
    {
        var tmp00 = other.m00 * m00 + other.m01 * m10 + other.m02 * m20;
        var tmp01 = other.m00 * m01 + other.m01 * m11 + other.m02 * m21;
        var tmp02 = other.m00 * m02 + other.m01 * m12 + other.m02 * m22;

        var tmp10 = other.m10 * m00 + other.m11 * m10 + other.m12 * m20;
        var tmp11 = other.m10 * m01 + other.m11 * m11 + other.m12 * m21;
        var tmp12 = other.m10 * m02 + other.m11 * m12 + other.m12 * m22;

        var tmp20 = other.m20 * m00 + other.m21 * m10 + other.m22 * m20;
        var tmp21 = other.m20 * m01 + other.m21 * m11 + other.m22 * m21;
        var tmp22 = other.m20 * m02 + other.m21 * m12 + other.m22 * m22;

        m00 = tmp00;
        m01 = tmp01;
        m02 = tmp02;

        m10 = tmp10;
        m11 = tmp11;
        m12 = tmp12;

        m20 = tmp20;
        m21 = tmp21;
        m22 = tmp22;
    }

    public function scale(sx: Float, sy: Float, sz: Float): Void
    {
        m00 *= sx;
        m01 *= sx;
        m02 *= sx;

        m10 *= sy;
        m11 *= sy;
        m12 *= sy;

        m20 *= sz;
        m21 *= sz;
        m22 *= sz;
    }
}
