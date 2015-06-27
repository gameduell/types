package types;

class Matrix3DataTools
{
    /**
     * Writes the values from the Matrix3 into a given Data object. Size and offset of the Data will be uneffected
     * by this function and have to be set before.
    **/
    static public function writeMatrix3IntoData(matrix: Matrix3, data: Data): Void
    {
        var oldOffset: Int = data.offset;

        data.writeFloat32(matrix.m00);
        data.offset += Data.SIZE_OF_FLOAT32;
        data.writeFloat32(matrix.m01);
        data.offset += Data.SIZE_OF_FLOAT32;
        data.writeFloat32(matrix.m02);
        data.offset += Data.SIZE_OF_FLOAT32;
        data.writeFloat32(matrix.m10);
        data.offset += Data.SIZE_OF_FLOAT32;
        data.writeFloat32(matrix.m11);
        data.offset += Data.SIZE_OF_FLOAT32;
        data.writeFloat32(matrix.m12);
        data.offset += Data.SIZE_OF_FLOAT32;
        data.writeFloat32(matrix.m20);
        data.offset += Data.SIZE_OF_FLOAT32;
        data.writeFloat32(matrix.m21);
        data.offset += Data.SIZE_OF_FLOAT32;
        data.writeFloat32(matrix.m22);

        data.offset = oldOffset;
    }
}