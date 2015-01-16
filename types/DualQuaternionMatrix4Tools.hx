package types;


import types.DataType;

class DualQuaternionMatrix4Tools
{
    static public function setFromDualQuaternion(matrix4: Matrix4, quaternion: DualQuaternion): Void
    {
        quaternion.normalize();

        matrix4.setIdentity();

/*


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
        matrix4.data.writeFloat(affineT.ty, DataTypeFloat32);*/
    }
}
