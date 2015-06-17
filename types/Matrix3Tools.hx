package types;

using types.Matrix3Tools;

class Matrix3Tools
{
    static public function transpose(matrix: Matrix3): Void
    {
        var m00: Float = matrix.m00;
        var m01: Float = matrix.m01;
        var m02: Float = matrix.m02;
        var m10: Float = matrix.m10;
        var m11: Float = matrix.m11;
        var m12: Float = matrix.m12;
        var m20: Float = matrix.m20;
        var m21: Float = matrix.m21;
        var m22: Float = matrix.m22;

        matrix.m01 = m10;
        matrix.m02 = m20;
        matrix.m10 = m01;
        matrix.m12 = m21;
        matrix.m20 = m02;
        matrix.m21 = m12;
    }

    static public function inverse(matrix: Matrix3): Void
    {
        var determinant: Float = matrix.getDeterminant();

        if (determinant == 0)
        {
            return;
        }

        var det: Float = 1 / determinant;

        var m00: Float = det * (matrix.m11 * matrix.m22 - matrix.m12 * matrix.m21);
        var m01: Float = det * (matrix.m02 * matrix.m21 - matrix.m01 * matrix.m22);
        var m02: Float = det * (matrix.m01 * matrix.m12 - matrix.m02 * matrix.m11);
        var m10: Float = det * (matrix.m12 * matrix.m20 - matrix.m10 * matrix.m22);
        var m11: Float = det * (matrix.m00 * matrix.m22 - matrix.m02 * matrix.m20);
        var m12: Float = det * (matrix.m02 * matrix.m10 - matrix.m00 * matrix.m12);
        var m20: Float = det * (matrix.m10 * matrix.m21 - matrix.m11 * matrix.m20);
        var m21: Float = det * (matrix.m01 * matrix.m20 - matrix.m00 * matrix.m11);
        var m22: Float = det * (matrix.m00 * matrix.m11 - matrix.m01 * matrix.m10);
    }

    static public function getDeterminant(matrix: Matrix3): Float
    {
        return matrix.m00 * matrix.m11 * matrix.m22 + matrix.m10 * matrix.m21 * matrix.m02 +
               matrix.m20 * matrix.m01 * matrix.m12 - matrix.m00 * matrix.m21 * matrix.m12 -
               matrix.m20 * matrix.m11 * matrix.m02 - matrix.m10 * matrix.m01 * matrix.m22;
    }
}
