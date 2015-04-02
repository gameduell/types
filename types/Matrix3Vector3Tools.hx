package types;

class Matrix3Vector3Tools
{
    static public function multiplyVector3(matrix3: Matrix3, vector: Vector3, out: Vector3): Void
    {
        var x = matrix3.m00 * vector.x + matrix3.m01 * vector.y + matrix3.m02 * vector.z;
        var y = matrix3.m10 * vector.x + matrix3.m11 * vector.y + matrix3.m12 * vector.z;
        var z = matrix3.m20 * vector.x + matrix3.m21 * vector.y + matrix3.m22 * vector.z;
        out.x = x;
        out.y = y;
        out.z = z;
    }
}