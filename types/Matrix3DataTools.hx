package types;

class Matrix3DataTools
{
    inline static private var floatSize: Int = 4;

    /**
     * Writes the values from the Matrix3 into a given Data object. Size and offset of the Data will be uneffected
     * by this function and have to be set before.
    **/
    static public function writeMatrix3IntoData(matrix: Matrix3, data: Data): Void
    {
        var oldOffset: Int = data.offset;

        data.writeFloat(matrix.m00, DataType.DataTypeFloat32);
        data.offset += floatSize;
        data.writeFloat(matrix.m01, DataType.DataTypeFloat32);
        data.offset += floatSize;
        data.writeFloat(matrix.m02, DataType.DataTypeFloat32);
        data.offset += floatSize;
        data.writeFloat(matrix.m10, DataType.DataTypeFloat32);
        data.offset += floatSize;
        data.writeFloat(matrix.m11, DataType.DataTypeFloat32);
        data.offset += floatSize;
        data.writeFloat(matrix.m12, DataType.DataTypeFloat32);
        data.offset += floatSize;
        data.writeFloat(matrix.m20, DataType.DataTypeFloat32);
        data.offset += floatSize;
        data.writeFloat(matrix.m21, DataType.DataTypeFloat32);
        data.offset += floatSize;
        data.writeFloat(matrix.m22, DataType.DataTypeFloat32);

        data.offset = oldOffset;
    }
}