package types;

import types.Matrix4;

class Matrix3Matrix4Tools
{
    static public function writeMatrix4IntoMatrix3(matrix3: Matrix3, matrix4: Matrix4): Void
    {
        var oldOffset: Int = matrix4.data.offset;

        matrix4.data.offset = 0 * Data.SIZE_OF_FLOAT32;
        matrix3.m00 = matrix4.data.readFloat32();
        matrix4.data.offset = 1 * Data.SIZE_OF_FLOAT32;
        matrix3.m01 = matrix4.data.readFloat32();
        matrix4.data.offset = 2 * Data.SIZE_OF_FLOAT32;
        matrix3.m02 = matrix4.data.readFloat32();

        matrix4.data.offset = 4 * Data.SIZE_OF_FLOAT32;
        matrix3.m10 = matrix4.data.readFloat32();
        matrix4.data.offset = 5 * Data.SIZE_OF_FLOAT32;
        matrix3.m11 = matrix4.data.readFloat32();
        matrix4.data.offset = 6 * Data.SIZE_OF_FLOAT32;
        matrix3.m12 = matrix4.data.readFloat32();

        matrix4.data.offset = 8 * Data.SIZE_OF_FLOAT32;
        matrix3.m20 = matrix4.data.readFloat32();
        matrix4.data.offset = 9 * Data.SIZE_OF_FLOAT32;
        matrix3.m21 = matrix4.data.readFloat32();
        matrix4.data.offset = 10 * Data.SIZE_OF_FLOAT32;
        matrix3.m22 = matrix4.data.readFloat32();

        matrix4.data.offset = oldOffset;
    }
}
