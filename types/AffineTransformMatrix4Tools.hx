package types;

import types.Data;
import types.DataType;

class AffineTransformMatrix4Tools
{
    static public function setFromMatrix4(affineT: AffineTransform, matrix4: Matrix4): Void
    {
        matrix4.data.offset = 0 * 4;
        affineT.a = matrix4.data.readFloat(DataTypeFloat32);

        matrix4.data.offset = 1 * 4;
        affineT.c = matrix4.data.readFloat(DataTypeFloat32);

        matrix4.data.offset = 3 * 4;
        affineT.tx = matrix4.data.readFloat(DataTypeFloat32);

        matrix4.data.offset = 4 * 4;
        affineT.b = matrix4.data.readFloat(DataTypeFloat32);

        matrix4.data.offset = 5 * 4;
        affineT.d = matrix4.data.readFloat(DataTypeFloat32);

        matrix4.data.offset = 7 * 4;
        affineT.ty = matrix4.data.readFloat(DataTypeFloat32);
    }

    static public function setFromAffineTransform(matrix4: Matrix4, affineT: AffineTransform): Void
    {
        matrix4.setIdentity();

        matrix4.data.offset = 0 * 4;
        matrix4.data.writeFloat(affineT.a, DataTypeFloat32);

        matrix4.data.offset = 1 * 4;
        matrix4.data.writeFloat(affineT.c, DataTypeFloat32);

        matrix4.data.offset = 3 * 4;
        matrix4.data.writeFloat(affineT.tx, DataTypeFloat32);

        matrix4.data.offset = 4 * 4;
        matrix4.data.writeFloat(affineT.b, DataTypeFloat32);

        matrix4.data.offset = 5 * 4;
        matrix4.data.writeFloat(affineT.d, DataTypeFloat32);

        matrix4.data.offset = 7 * 4;
        matrix4.data.writeFloat(affineT.ty, DataTypeFloat32);
    }
}