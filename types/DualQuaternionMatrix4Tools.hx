package types;

import types.Data;
import types.DataType;

class DualQuaternionMatrix4Tools
{
    static private var translation: Vector3 = new Vector3();

    static public function setFromDualQuaternion(matrix4: Matrix4, dualQuaternion: DualQuaternion): Void
    {
        dualQuaternion.normalize();
        dualQuaternion.getTranslation(translation);

        var w: Float = dualQuaternion.real.w;
        var x: Float = dualQuaternion.real.x;
        var y: Float = dualQuaternion.real.y;
        var z: Float = dualQuaternion.real.z;

        var m11: Float = w*w + x*x - y*y - z*z;
        var m12: Float = 2.0*x*y + 2.0*w*z;
        var m13: Float = 2.0*x*z - 2.0*w*y;
        var m14: Float = 0.0;

        var m21: Float = 2.0*x*y - 2.0*w*z;
        var m22: Float = w*w + y*y - x*x - z*z;
        var m23: Float = 2.0*y*z + 2.0*w*x;
        var m24: Float = 0.0;

        var m31: Float = 2.0*x*z + 2.0*w*y;
        var m32: Float = 2.0*y*z - 2.0*w*x;
        var m33: Float = w*w + z*z - x*x - y*y;
        var m34: Float = 0.0;

        var m41: Float = translation.x;
        var m42: Float = translation.y;
        var m43: Float = translation.z;
        var m44: Float = 1.0;


        matrix4.data.offset = 0 * 4;
        matrix4.data.writeFloat(m11, DataTypeFloat32);

        matrix4.data.offset = 1 * 4;
        matrix4.data.writeFloat(m21, DataTypeFloat32);

        matrix4.data.offset = 2 * 4;
        matrix4.data.writeFloat(m31, DataTypeFloat32);

        matrix4.data.offset = 3 * 4;
        matrix4.data.writeFloat(m41, DataTypeFloat32);


        matrix4.data.offset = 4 * 4;
        matrix4.data.writeFloat(m12, DataTypeFloat32);

        matrix4.data.offset = 5 * 4;
        matrix4.data.writeFloat(m22, DataTypeFloat32);

        matrix4.data.offset = 6 * 4;
        matrix4.data.writeFloat(m32, DataTypeFloat32);

        matrix4.data.offset = 7 * 4;
        matrix4.data.writeFloat(m42, DataTypeFloat32);


        matrix4.data.offset = 8 * 4;
        matrix4.data.writeFloat(m13, DataTypeFloat32);

        matrix4.data.offset = 9 * 4;
        matrix4.data.writeFloat(m23, DataTypeFloat32);

        matrix4.data.offset = 10 * 4;
        matrix4.data.writeFloat(m33, DataTypeFloat32);

        matrix4.data.offset = 11 * 4;
        matrix4.data.writeFloat(m43, DataTypeFloat32);


        matrix4.data.offset = 12 * 4;
        matrix4.data.writeFloat(m14, DataTypeFloat32);

        matrix4.data.offset = 13 * 4;
        matrix4.data.writeFloat(m24, DataTypeFloat32);

        matrix4.data.offset = 14 * 4;
        matrix4.data.writeFloat(m34, DataTypeFloat32);

        matrix4.data.offset = 15 * 4;
        matrix4.data.writeFloat(m44, DataTypeFloat32);
    }
}