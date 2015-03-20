package types;

import types.Data;
import types.DataType;

class AffineTransformMatrix4Tools
{
    static public function setFromMatrix4(affineT: AffineTransform, matrix4: Matrix4): Void
    {
        matrix4.data.offset = 0 * 4;
        affineT.m00 = matrix4.data.readFloat(DataTypeFloat32);

        matrix4.data.offset = 1 * 4;
        affineT.m01 = matrix4.data.readFloat(DataTypeFloat32);

        matrix4.data.offset = 3 * 4;
        affineT.m02 = matrix4.data.readFloat(DataTypeFloat32);

        matrix4.data.offset = 4 * 4;
        affineT.m10 = matrix4.data.readFloat(DataTypeFloat32);

        matrix4.data.offset = 5 * 4;
        affineT.m11 = matrix4.data.readFloat(DataTypeFloat32);

        matrix4.data.offset = 7 * 4;
        affineT.m12 = matrix4.data.readFloat(DataTypeFloat32);

        matrix4.data.offset = 0;
    }

    static public function setFromAffineTransform(matrix4: Matrix4, affineT: AffineTransform): Void
    {
        matrix4.setIdentity();

        matrix4.data.offset = 0 * 4;
        matrix4.data.writeFloat(affineT.m00, DataTypeFloat32);

        matrix4.data.offset = 1 * 4;
        matrix4.data.writeFloat(affineT.m01, DataTypeFloat32);

        matrix4.data.offset = 3 * 4;
        matrix4.data.writeFloat(affineT.m02, DataTypeFloat32);

        matrix4.data.offset = 4 * 4;
        matrix4.data.writeFloat(affineT.m10, DataTypeFloat32);

        matrix4.data.offset = 5 * 4;
        matrix4.data.writeFloat(affineT.m11, DataTypeFloat32);

        matrix4.data.offset = 7 * 4;
        matrix4.data.writeFloat(affineT.m12, DataTypeFloat32);

        matrix4.data.offset = 0;
    }
}
