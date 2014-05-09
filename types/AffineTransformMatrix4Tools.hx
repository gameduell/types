package types;

import types.Data;
import types.DataType;

class AffineTransformMatrix4Tools
{
    static public function setFromMatrix4(affineT : AffineTransform, matrix4 : Matrix4) : Void
    {
        affineT.data.offset = 0 * 4;
        matrix4.data.offset = 0 * 4;
        affineT.data.writeFloat(matrix4.data.readFloat(DataTypeFloat), DataTypeFloat);

        affineT.data.offset = 1 * 4;
        matrix4.data.offset = 1 * 4;
        affineT.data.writeFloat(matrix4.data.readFloat(DataTypeFloat), DataTypeFloat);

        affineT.data.offset = 2 * 4;
        matrix4.data.offset = 4 * 4;
        affineT.data.writeFloat(matrix4.data.readFloat(DataTypeFloat), DataTypeFloat);

        affineT.data.offset = 3 * 4;
        matrix4.data.offset = 5 * 4;
        affineT.data.writeFloat(matrix4.data.readFloat(DataTypeFloat), DataTypeFloat);

        affineT.data.offset = 4 * 4;
        matrix4.data.offset = 12 * 4;
        affineT.data.writeFloat(matrix4.data.readFloat(DataTypeFloat), DataTypeFloat);

        affineT.data.offset = 5 * 4;
        matrix4.data.offset = 13 * 4;
        affineT.data.writeFloat(matrix4.data.readFloat(DataTypeFloat), DataTypeFloat);
    }

    static public function setFromAffineTransform( matrix4 : Matrix4, affineT : AffineTransform) : Void
    {
        matrix4.setIdentity();

        matrix4.data.offset = 0 * 4;
        affineT.data.offset = 0 * 4;
        matrix4.data.writeFloat(affineT.data.readFloat(DataTypeFloat),DataTypeFloat);

        matrix4.data.offset = 1 * 4;
        affineT.data.offset = 1 * 4;
        matrix4.data.writeFloat(affineT.data.readFloat(DataTypeFloat),DataTypeFloat);

        matrix4.data.offset = 4 * 4;
        affineT.data.offset = 2 * 4;
        matrix4.data.writeFloat(affineT.data.readFloat(DataTypeFloat),DataTypeFloat);

        matrix4.data.offset = 5 * 4;
        affineT.data.offset = 3 * 4;
        matrix4.data.writeFloat(affineT.data.readFloat(DataTypeFloat),DataTypeFloat);

        matrix4.data.offset = 12 * 4;
        affineT.data.offset = 4 * 4;
        matrix4.data.writeFloat(affineT.data.readFloat(DataTypeFloat),DataTypeFloat);

        matrix4.data.offset = 13 * 4;
        affineT.data.offset = 5 * 4;
        matrix4.data.writeFloat(affineT.data.readFloat(DataTypeFloat),DataTypeFloat);
    }
}