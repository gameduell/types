package types;

import types.Matrix4;
import types.DataType;
import types.Vector3;
import types.Data;

using types.Matrix4Tools;

class Matrix4Tools
{
    inline static private var floatSize: Int = 4;

    static private var workingVectorA: Vector3 = new Vector3();
    static private var workingVectorB: Vector3 = new Vector3();
    static private var workingVectorC: Vector3 = new Vector3();

    static private var workingMatrixA: Matrix4 = new Matrix4();
    static private var workingMatrixB: Matrix4 = new Matrix4();
    static private var workingMatrixC: Matrix4 = new Matrix4();

    static public function translate(matrix: Matrix4, tx: Float, ty: Float, tz: Float): Void
    {
        var oldOffset: Int = matrix.data.offset;

        matrix.data.offset = 0 * floatSize;
        var a11: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 1 * floatSize;
        var a12: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 2 * floatSize;
        var a13: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 3 * floatSize;
        var a14: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 4 * floatSize;
        var a21: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 5 * floatSize;
        var a22: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 6 * floatSize;
        var a23: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 7 * floatSize;
        var a24: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 8 * floatSize;
        var a31: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 9 * floatSize;
        var a32: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 10 * floatSize;
        var a33: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 11 * floatSize;
        var a34: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 12 * floatSize;
        var a41: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 13 * floatSize;
        var a42: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 14 * floatSize;
        var a43: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 15 * floatSize;
        var a44: Float = matrix.data.readFloat(DataType.DataTypeFloat32);

        var b14: Float = a11 * tx + a12 * ty + a13 * tz + a14;
        var b24: Float = a21 * tx + a22 * ty + a23 * tz + a24;
        var b34: Float = a31 * tx + a32 * ty + a33 * tz + a34;
        var b44: Float = a41 * tx + a42 * ty + a43 * tz + a44;

        matrix.data.offset = 3 * floatSize;
        matrix.data.writeFloat(b14, DataType.DataTypeFloat32);
        matrix.data.offset = 7 * floatSize;
        matrix.data.writeFloat(b24, DataType.DataTypeFloat32);
        matrix.data.offset = 11 * floatSize;
        matrix.data.writeFloat(b34, DataType.DataTypeFloat32);
        matrix.data.offset = 15 * floatSize;
        matrix.data.writeFloat(b44, DataType.DataTypeFloat32);

        matrix.data.offset = oldOffset;
    }

    static public function rotate(matrix: Matrix4, rx: Float, ry: Float, rz: Float): Void
    {
        workingMatrixA.setRotationX(rx);
        workingMatrixB.setRotationY(ry);
        workingMatrixC.setRotationZ(rz);

        matrix.multiply(workingMatrixC);
        matrix.multiply(workingMatrixB);
        matrix.multiply(workingMatrixA);
    }

    static public function rotateWithVector3(matrix: Matrix4, radians: Float, vector: Vector3): Void
    {
        workingMatrixA.setRotationWithVector3(radians, vector);
        matrix.multiply(workingMatrixA);
    }

    static public function setLookAt(matrix: Matrix4, eye: Vector3, center: Vector3, up: Vector3): Void
    {
        workingVectorA.set(eye);
        workingVectorA.subtract(center);
        workingVectorA.normalize();

        workingVectorB.set(up);
        workingVectorB.cross(workingVectorA);
        workingVectorB.normalize();

        workingVectorC.set(workingVectorA);
        workingVectorC.cross(workingVectorB);

        var oldOffset: Int = matrix.data.offset;

        matrix.data.offset = 0 * floatSize;
        matrix.data.writeFloat(workingVectorB.x, DataType.DataTypeFloat32);
        matrix.data.offset = 1 * floatSize;
        matrix.data.writeFloat(workingVectorB.y, DataType.DataTypeFloat32);
        matrix.data.offset = 2 * floatSize;
        matrix.data.writeFloat(workingVectorB.z, DataType.DataTypeFloat32);

        matrix.data.offset = 4 * floatSize;
        matrix.data.writeFloat(workingVectorC.x, DataType.DataTypeFloat32);
        matrix.data.offset = 5 * floatSize;
        matrix.data.writeFloat(workingVectorC.y, DataType.DataTypeFloat32);
        matrix.data.offset = 6 * floatSize;
        matrix.data.writeFloat(workingVectorC.z, DataType.DataTypeFloat32);

        matrix.data.offset = 8 * floatSize;
        matrix.data.writeFloat(workingVectorA.x, DataType.DataTypeFloat32);
        matrix.data.offset = 9 * floatSize;
        matrix.data.writeFloat(workingVectorA.y, DataType.DataTypeFloat32);
        matrix.data.offset = 10 * floatSize;
        matrix.data.writeFloat(workingVectorA.z, DataType.DataTypeFloat32);

        matrix.data.offset = 12 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 13 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 14 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 15 * floatSize;
        matrix.data.writeFloat(1.0, DataType.DataTypeFloat32);

        workingVectorA.negate();
        workingVectorB.negate();
        workingVectorC.negate();

        matrix.data.offset = 3 * floatSize;
        matrix.data.writeFloat(Vector3.dotProduct(workingVectorB, eye), DataType.DataTypeFloat32);
        matrix.data.offset = 7 * floatSize;
        matrix.data.writeFloat(Vector3.dotProduct(workingVectorC, eye), DataType.DataTypeFloat32);
        matrix.data.offset = 11 * floatSize;
        matrix.data.writeFloat(Vector3.dotProduct(workingVectorA, eye), DataType.DataTypeFloat32);

        matrix.data.offset = oldOffset;
    }

    public static function setTranslation(matrix: Matrix4, tx: Float, ty: Float, tz: Float): Void
    {
        var oldOffset: Int = matrix.data.offset;

        matrix.data.offset = 0 * floatSize;
        matrix.data.writeFloat(1.0, DataType.DataTypeFloat32);
        matrix.data.offset = 1 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 2 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 3 * floatSize;
        matrix.data.writeFloat(tx, DataType.DataTypeFloat32);
        matrix.data.offset = 4 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 5 * floatSize;
        matrix.data.writeFloat(1.0, DataType.DataTypeFloat32);
        matrix.data.offset = 6 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 7 * floatSize;
        matrix.data.writeFloat(ty, DataType.DataTypeFloat32);
        matrix.data.offset = 8 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 9 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 10 * floatSize;
        matrix.data.writeFloat(1.0, DataType.DataTypeFloat32);
        matrix.data.offset = 11 * floatSize;
        matrix.data.writeFloat(tz, DataType.DataTypeFloat32);
        matrix.data.offset = 12 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 13 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 14 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 15 * floatSize;
        matrix.data.writeFloat(1.0, DataType.DataTypeFloat32);

        matrix.data.offset = oldOffset;
    }

    static public function setRotationWithVector3(matrix: Matrix4, radians: Float, vector: Vector3): Void
    {
        workingVectorA.set(vector);
        workingVectorA.normalize();

        var cos: Float = Math.cos(radians);
        var cosp: Float = 1.0 - cos;
        var sin: Float = Math.sin(radians);

        var b11: Float = cos + cosp * workingVectorA.x * workingVectorA.x;
        var b12: Float = cosp * workingVectorA.x * workingVectorA.y - workingVectorA.z * sin;
        var b13: Float = cosp * workingVectorA.x * workingVectorA.z + workingVectorA.y * sin;
        var b14: Float = 0.0;
        var b21: Float = cosp * workingVectorA.x * workingVectorA.y + workingVectorA.z * sin;
        var b22: Float = cos + cosp * workingVectorA.y * workingVectorA.y;
        var b23: Float = cosp * workingVectorA.y * workingVectorA.z - workingVectorA.x * sin;
        var b24: Float = 0.0;
        var b31: Float = cosp * workingVectorA.x * workingVectorA.z - workingVectorA.y * sin;
        var b32: Float = cosp * workingVectorA.y * workingVectorA.z + workingVectorA.x * sin;
        var b33: Float = cos + cosp * workingVectorA.z * workingVectorA.z;
        var b34: Float = 0.0;
        var b41: Float = 0.0;
        var b42: Float = 0.0;
        var b43: Float = 0.0;
        var b44: Float = 1.0;

        var oldOffset: Int = matrix.data.offset;

        matrix.data.offset = 0 * floatSize;
        matrix.data.writeFloat(b11, DataType.DataTypeFloat32);
        matrix.data.offset = 1 * floatSize;
        matrix.data.writeFloat(b12, DataType.DataTypeFloat32);
        matrix.data.offset = 2 * floatSize;
        matrix.data.writeFloat(b13, DataType.DataTypeFloat32);
        matrix.data.offset = 3 * floatSize;
        matrix.data.writeFloat(b14, DataType.DataTypeFloat32);
        matrix.data.offset = 4 * floatSize;
        matrix.data.writeFloat(b21, DataType.DataTypeFloat32);
        matrix.data.offset = 5 * floatSize;
        matrix.data.writeFloat(b22, DataType.DataTypeFloat32);
        matrix.data.offset = 6 * floatSize;
        matrix.data.writeFloat(b23, DataType.DataTypeFloat32);
        matrix.data.offset = 7 * floatSize;
        matrix.data.writeFloat(b24, DataType.DataTypeFloat32);
        matrix.data.offset = 8 * floatSize;
        matrix.data.writeFloat(b31, DataType.DataTypeFloat32);
        matrix.data.offset = 9 * floatSize;
        matrix.data.writeFloat(b32, DataType.DataTypeFloat32);
        matrix.data.offset = 10 * floatSize;
        matrix.data.writeFloat(b33, DataType.DataTypeFloat32);
        matrix.data.offset = 11 * floatSize;
        matrix.data.writeFloat(b34, DataType.DataTypeFloat32);
        matrix.data.offset = 12 * floatSize;
        matrix.data.writeFloat(b41, DataType.DataTypeFloat32);
        matrix.data.offset = 13 * floatSize;
        matrix.data.writeFloat(b42, DataType.DataTypeFloat32);
        matrix.data.offset = 14 * floatSize;
        matrix.data.writeFloat(b43, DataType.DataTypeFloat32);
        matrix.data.offset = 15 * floatSize;
        matrix.data.writeFloat(b44, DataType.DataTypeFloat32);

        matrix.data.offset = oldOffset;
    }

    static public function setRotationX(matrix: Matrix4, rad: Float): Void
    {
        var c: Float = Math.cos(rad);
        var s: Float = Math.sin(rad);

        var oldOffset: Int = matrix.data.offset;

        matrix.data.offset = 0 * floatSize;
        matrix.data.writeFloat(1.0, DataType.DataTypeFloat32);
        matrix.data.offset = 1 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 2 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 3 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 4 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 5 * floatSize;
        matrix.data.writeFloat(c, DataType.DataTypeFloat32);
        matrix.data.offset = 6 * floatSize;
        matrix.data.writeFloat(-s, DataType.DataTypeFloat32);
        matrix.data.offset = 7 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 8 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 9 * floatSize;
        matrix.data.writeFloat(s, DataType.DataTypeFloat32);
        matrix.data.offset = 10 * floatSize;
        matrix.data.writeFloat(c, DataType.DataTypeFloat32);
        matrix.data.offset = 11 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 12 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 13 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 14 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 15 * floatSize;
        matrix.data.writeFloat(1.0, DataType.DataTypeFloat32);

        matrix.data.offset = oldOffset;
    }

    static public function setRotationY(matrix: Matrix4, rad: Float): Void
    {
        var c: Float = Math.cos(rad);
        var s: Float = Math.sin(rad);

        var oldOffset: Int = matrix.data.offset;

        matrix.data.offset = 0 * floatSize;
        matrix.data.writeFloat(c, DataType.DataTypeFloat32);
        matrix.data.offset = 1 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 2 * floatSize;
        matrix.data.writeFloat(s, DataType.DataTypeFloat32);
        matrix.data.offset = 3 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 4 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 5 * floatSize;
        matrix.data.writeFloat(1.0, DataType.DataTypeFloat32);
        matrix.data.offset = 6 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 7 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 8 * floatSize;
        matrix.data.writeFloat(-s, DataType.DataTypeFloat32);
        matrix.data.offset = 9 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 10 * floatSize;
        matrix.data.writeFloat(c, DataType.DataTypeFloat32);
        matrix.data.offset = 11 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 12 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 13 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 14 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 15 * floatSize;
        matrix.data.writeFloat(1.0, DataType.DataTypeFloat32);

        matrix.data.offset = oldOffset;
    }

    static public function setRotationZ(matrix: Matrix4, rad: Float): Void
    {
        var c: Float = Math.cos(rad);
        var s: Float = Math.sin(rad);

        var oldOffset: Int = matrix.data.offset;

        matrix.data.offset = 0 * floatSize;
        matrix.data.writeFloat(c, DataType.DataTypeFloat32);
        matrix.data.offset = 1 * floatSize;
        matrix.data.writeFloat(-s, DataType.DataTypeFloat32);
        matrix.data.offset = 2 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 3 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 4 * floatSize;
        matrix.data.writeFloat(s, DataType.DataTypeFloat32);
        matrix.data.offset = 5 * floatSize;
        matrix.data.writeFloat(c, DataType.DataTypeFloat32);
        matrix.data.offset = 6 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 7 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 8 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 9 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 10 * floatSize;
        matrix.data.writeFloat(1.0, DataType.DataTypeFloat32);
        matrix.data.offset = 11 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 12 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 13 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 14 * floatSize;
        matrix.data.writeFloat(0.0, DataType.DataTypeFloat32);
        matrix.data.offset = 15 * floatSize;
        matrix.data.writeFloat(1.0, DataType.DataTypeFloat32);

        matrix.data.offset = oldOffset;
    }

    static public function interpolate(matrix: Matrix4, start: Matrix4, end: Matrix4, v: Float): Void
    {
        var oldOffset: Int = matrix.data.offset;
        var oldOffsetStart: Int = start.data.offset;
        var oldOffsetEnd: Int = end.data.offset;

        start.data.offset = 0 * floatSize;
        var a11: Float = start.data.readFloat(DataType.DataTypeFloat32);
        start.data.offset = 1 * floatSize;
        var a12: Float = start.data.readFloat(DataType.DataTypeFloat32);
        start.data.offset = 2 * floatSize;
        var a13: Float = start.data.readFloat(DataType.DataTypeFloat32);
        start.data.offset = 3 * floatSize;
        var a14: Float = start.data.readFloat(DataType.DataTypeFloat32);
        start.data.offset = 4 * floatSize;
        var a21: Float = start.data.readFloat(DataType.DataTypeFloat32);
        start.data.offset = 5 * floatSize;
        var a22: Float = start.data.readFloat(DataType.DataTypeFloat32);
        start.data.offset = 6 * floatSize;
        var a23: Float = start.data.readFloat(DataType.DataTypeFloat32);
        start.data.offset = 7 * floatSize;
        var a24: Float = start.data.readFloat(DataType.DataTypeFloat32);
        start.data.offset = 8 * floatSize;
        var a31: Float = start.data.readFloat(DataType.DataTypeFloat32);
        start.data.offset = 9 * floatSize;
        var a32: Float = start.data.readFloat(DataType.DataTypeFloat32);
        start.data.offset = 10 * floatSize;
        var a33: Float = start.data.readFloat(DataType.DataTypeFloat32);
        start.data.offset = 11 * floatSize;
        var a34: Float = start.data.readFloat(DataType.DataTypeFloat32);
        start.data.offset = 12 * floatSize;
        var a41: Float = start.data.readFloat(DataType.DataTypeFloat32);
        start.data.offset = 13 * floatSize;
        var a42: Float = start.data.readFloat(DataType.DataTypeFloat32);
        start.data.offset = 14 * floatSize;
        var a43: Float = start.data.readFloat(DataType.DataTypeFloat32);
        start.data.offset = 15 * floatSize;
        var a44: Float = start.data.readFloat(DataType.DataTypeFloat32);

        end.data.offset = 0 * floatSize;
        var b11: Float = end.data.readFloat(DataType.DataTypeFloat32);
        end.data.offset = 1 * floatSize;
        var b12: Float = end.data.readFloat(DataType.DataTypeFloat32);
        end.data.offset = 2 * floatSize;
        var b13: Float = end.data.readFloat(DataType.DataTypeFloat32);
        end.data.offset = 3 * floatSize;
        var b14: Float = end.data.readFloat(DataType.DataTypeFloat32);
        end.data.offset = 4 * floatSize;
        var b21: Float = end.data.readFloat(DataType.DataTypeFloat32);
        end.data.offset = 5 * floatSize;
        var b22: Float = end.data.readFloat(DataType.DataTypeFloat32);
        end.data.offset = 6 * floatSize;
        var b23: Float = end.data.readFloat(DataType.DataTypeFloat32);
        end.data.offset = 7 * floatSize;
        var b24: Float = end.data.readFloat(DataType.DataTypeFloat32);
        end.data.offset = 8 * floatSize;
        var b31: Float = end.data.readFloat(DataType.DataTypeFloat32);
        end.data.offset = 9 * floatSize;
        var b32: Float = end.data.readFloat(DataType.DataTypeFloat32);
        end.data.offset = 10 * floatSize;
        var b33: Float = end.data.readFloat(DataType.DataTypeFloat32);
        end.data.offset = 11 * floatSize;
        var b34: Float = end.data.readFloat(DataType.DataTypeFloat32);
        end.data.offset = 12 * floatSize;
        var b41: Float = end.data.readFloat(DataType.DataTypeFloat32);
        end.data.offset = 13 * floatSize;
        var b42: Float = end.data.readFloat(DataType.DataTypeFloat32);
        end.data.offset = 14 * floatSize;
        var b43: Float = end.data.readFloat(DataType.DataTypeFloat32);
        end.data.offset = 15 * floatSize;
        var b44: Float = end.data.readFloat(DataType.DataTypeFloat32);

        var c11: Float = a11 + (b11 - a11) * v;
        var c12: Float = a12 + (b12 - a12) * v;
        var c13: Float = a13 + (b13 - a13) * v;
        var c14: Float = a14 + (b14 - a14) * v;
        var c21: Float = a21 + (b21 - a21) * v;
        var c22: Float = a22 + (b22 - a22) * v;
        var c23: Float = a23 + (b23 - a23) * v;
        var c24: Float = a24 + (b24 - a24) * v;
        var c31: Float = a31 + (b31 - a31) * v;
        var c32: Float = a32 + (b32 - a32) * v;
        var c33: Float = a33 + (b33 - a33) * v;
        var c34: Float = a34 + (b34 - a34) * v;
        var c41: Float = a41 + (b41 - a41) * v;
        var c42: Float = a42 + (b42 - a42) * v;
        var c43: Float = a43 + (b43 - a43) * v;
        var c44: Float = a44 + (b44 - a44) * v;

        matrix.data.offset = 0 * floatSize;
        matrix.data.writeFloat(c11, DataType.DataTypeFloat32);
        matrix.data.offset = 1 * floatSize;
        matrix.data.writeFloat(c12, DataType.DataTypeFloat32);
        matrix.data.offset = 2 * floatSize;
        matrix.data.writeFloat(c13, DataType.DataTypeFloat32);
        matrix.data.offset = 3 * floatSize;
        matrix.data.writeFloat(c14, DataType.DataTypeFloat32);
        matrix.data.offset = 4 * floatSize;
        matrix.data.writeFloat(c21, DataType.DataTypeFloat32);
        matrix.data.offset = 5 * floatSize;
        matrix.data.writeFloat(c22, DataType.DataTypeFloat32);
        matrix.data.offset = 6 * floatSize;
        matrix.data.writeFloat(c23, DataType.DataTypeFloat32);
        matrix.data.offset = 7 * floatSize;
        matrix.data.writeFloat(c24, DataType.DataTypeFloat32);
        matrix.data.offset = 8 * floatSize;
        matrix.data.writeFloat(c31, DataType.DataTypeFloat32);
        matrix.data.offset = 9 * floatSize;
        matrix.data.writeFloat(c32, DataType.DataTypeFloat32);
        matrix.data.offset = 10 * floatSize;
        matrix.data.writeFloat(c33, DataType.DataTypeFloat32);
        matrix.data.offset = 11 * floatSize;
        matrix.data.writeFloat(c34, DataType.DataTypeFloat32);
        matrix.data.offset = 12 * floatSize;
        matrix.data.writeFloat(c41, DataType.DataTypeFloat32);
        matrix.data.offset = 13 * floatSize;
        matrix.data.writeFloat(c42, DataType.DataTypeFloat32);
        matrix.data.offset = 14 * floatSize;
        matrix.data.writeFloat(c43, DataType.DataTypeFloat32);
        matrix.data.offset = 15 * floatSize;
        matrix.data.writeFloat(c44, DataType.DataTypeFloat32);

        matrix.data.offset = oldOffset;
        start.data.offset = oldOffsetStart;
        end.data.offset = oldOffsetEnd;
    }

    static public function transpose(matrix: Matrix4): Void
    {
        var oldOffset: Int = matrix.data.offset;

        matrix.data.offset = 0 * floatSize;
        var a11: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 1 * floatSize;
        var a12: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 2 * floatSize;
        var a13: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 3 * floatSize;
        var a14: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 4 * floatSize;
        var a21: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 5 * floatSize;
        var a22: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 6 * floatSize;
        var a23: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 7 * floatSize;
        var a24: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 8 * floatSize;
        var a31: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 9 * floatSize;
        var a32: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 10 * floatSize;
        var a33: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 11 * floatSize;
        var a34: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 12 * floatSize;
        var a41: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 13 * floatSize;
        var a42: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 14 * floatSize;
        var a43: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 15 * floatSize;
        var a44: Float = matrix.data.readFloat(DataType.DataTypeFloat32);

        matrix.data.offset = 1 * floatSize;
        matrix.data.writeFloat(a21, DataType.DataTypeFloat32);
        matrix.data.offset = 2 * floatSize;
        matrix.data.writeFloat(a31, DataType.DataTypeFloat32);
        matrix.data.offset = 3 * floatSize;
        matrix.data.writeFloat(a41, DataType.DataTypeFloat32);
        matrix.data.offset = 4 * floatSize;
        matrix.data.writeFloat(a12, DataType.DataTypeFloat32);
        matrix.data.offset = 6 * floatSize;
        matrix.data.writeFloat(a32, DataType.DataTypeFloat32);
        matrix.data.offset = 7 * floatSize;
        matrix.data.writeFloat(a42, DataType.DataTypeFloat32);
        matrix.data.offset = 8 * floatSize;
        matrix.data.writeFloat(a13, DataType.DataTypeFloat32);
        matrix.data.offset = 9 * floatSize;
        matrix.data.writeFloat(a23, DataType.DataTypeFloat32);
        matrix.data.offset = 11 * floatSize;
        matrix.data.writeFloat(a43, DataType.DataTypeFloat32);
        matrix.data.offset = 12 * floatSize;
        matrix.data.writeFloat(a14, DataType.DataTypeFloat32);
        matrix.data.offset = 13 * floatSize;
        matrix.data.writeFloat(a24, DataType.DataTypeFloat32);
        matrix.data.offset = 14 * floatSize;
        matrix.data.writeFloat(a34, DataType.DataTypeFloat32);

        matrix.data.offset = oldOffset;
    }

    static public function inverse(matrix: Matrix4): Void
    {
        var determiant = getDeterminant(matrix);

        if (determiant == 0)
        {
            return;
        }

        var det = 1 / determiant;
        var oldOffset: Int = matrix.data.offset;

        matrix.data.offset = 0 * floatSize;
        var a11: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 1 * floatSize;
        var a12: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 2 * floatSize;
        var a13: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 3 * floatSize;
        var a14: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 4 * floatSize;
        var a21: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 5 * floatSize;
        var a22: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 6 * floatSize;
        var a23: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 7 * floatSize;
        var a24: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 8 * floatSize;
        var a31: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 9 * floatSize;
        var a32: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 10 * floatSize;
        var a33: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 11 * floatSize;
        var a34: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 12 * floatSize;
        var a41: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 13 * floatSize;
        var a42: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 14 * floatSize;
        var a43: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 15 * floatSize;
        var a44: Float = matrix.data.readFloat(DataType.DataTypeFloat32);

        var b11: Float = (a22 * a33 * a44) + (a23 * a34 * a42) + (a24 * a32 * a43) - (a22 * a34 * a43) - (a23 * a32 * a44) - (a24 * a33 * a42);
        var b12: Float = (a12 * a34 * a43) + (a13 * a32 * a44) + (a14 * a33 * a42) - (a12 * a33 * a44) - (a13 * a34 * a42) - (a14 * a32 * a43);
        var b13: Float = (a12 * a23 * a44) + (a13 * a24 * a42) + (a14 * a22 * a43) - (a12 * a24 * a43) - (a13 * a22 * a44) - (a14 * a23 * a42);
        var b14: Float = (a12 * a24 * a33) + (a13 * a22 * a34) + (a14 * a23 * a32) - (a12 * a23 * a34) - (a13 * a24 * a32) - (a14 * a22 * a33);
        var b21: Float = (a21 * a34 * a43) + (a23 * a31 * a44) + (a24 * a33 * a41) - (a21 * a33 * a44) - (a23 * a34 * a41) - (a24 * a31 * a43);
        var b22: Float = (a11 * a33 * a44) + (a13 * a34 * a41) + (a14 * a31 * a43) - (a11 * a34 * a43) - (a13 * a31 * a44) - (a14 * a33 * a41);
        var b23: Float = (a11 * a24 * a43) + (a13 * a21 * a44) + (a14 * a23 * a41) - (a11 * a23 * a44) - (a13 * a24 * a41) - (a14 * a21 * a43);
        var b24: Float = (a11 * a23 * a34) + (a13 * a24 * a31) + (a14 * a21 * a33) - (a11 * a24 * a33) - (a13 * a21 * a34) - (a14 * a23 * a31);
        var b31: Float = (a21 * a32 * a44) + (a22 * a34 * a41) + (a24 * a31 * a42) - (a21 * a34 * a42) - (a22 * a31 * a44) - (a24 * a32 * a41);
        var b32: Float = (a11 * a34 * a42) + (a12 * a31 * a44) + (a14 * a32 * a41) - (a11 * a32 * a44) - (a12 * a34 * a41) - (a14 * a31 * a42);
        var b33: Float = (a11 * a22 * a44) + (a12 * a24 * a41) + (a14 * a21 * a42) - (a11 * a24 * a42) - (a12 * a21 * a44) - (a14 * a22 * a41);
        var b34: Float = (a11 * a24 * a32) + (a12 * a21 * a34) + (a14 * a22 * a31) - (a11 * a22 * a34) - (a12 * a24 * a31) - (a14 * a21 * a32);
        var b41: Float = (a21 * a33 * a42) + (a22 * a31 * a43) + (a23 * a32 * a41) - (a21 * a32 * a43) - (a22 * a33 * a41) - (a23 * a31 * a42);
        var b42: Float = (a11 * a32 * a43) + (a12 * a33 * a41) + (a13 * a31 * a42) - (a11 * a33 * a42) - (a12 * a31 * a43) - (a13 * a32 * a41);
        var b43: Float = (a11 * a23 * a42) + (a12 * a21 * a43) + (a13 * a22 * a41) - (a11 * a22 * a43) - (a12 * a23 * a41) - (a13 * a21 * a42);
        var b44: Float = (a11 * a22 * a33) + (a12 * a23 * a31) + (a13 * a21 * a32) - (a11 * a23 * a32) - (a12 * a21 * a33) - (a13 * a22 * a31);

        matrix.data.offset = 0 * floatSize;
        matrix.data.writeFloat(det * b11, DataType.DataTypeFloat32);
        matrix.data.offset = 1 * floatSize;
        matrix.data.writeFloat(det * b12, DataType.DataTypeFloat32);
        matrix.data.offset = 2 * floatSize;
        matrix.data.writeFloat(det * b13, DataType.DataTypeFloat32);
        matrix.data.offset = 3 * floatSize;
        matrix.data.writeFloat(det * b14, DataType.DataTypeFloat32);
        matrix.data.offset = 4 * floatSize;
        matrix.data.writeFloat(det * b21, DataType.DataTypeFloat32);
        matrix.data.offset = 5 * floatSize;
        matrix.data.writeFloat(det * b22, DataType.DataTypeFloat32);
        matrix.data.offset = 6 * floatSize;
        matrix.data.writeFloat(det * b23, DataType.DataTypeFloat32);
        matrix.data.offset = 7 * floatSize;
        matrix.data.writeFloat(det * b24, DataType.DataTypeFloat32);
        matrix.data.offset = 8 * floatSize;
        matrix.data.writeFloat(det * b31, DataType.DataTypeFloat32);
        matrix.data.offset = 9 * floatSize;
        matrix.data.writeFloat(det * b32, DataType.DataTypeFloat32);
        matrix.data.offset = 10 * floatSize;
        matrix.data.writeFloat(det * b33, DataType.DataTypeFloat32);
        matrix.data.offset = 11 * floatSize;
        matrix.data.writeFloat(det * b34, DataType.DataTypeFloat32);
        matrix.data.offset = 12 * floatSize;
        matrix.data.writeFloat(det * b41, DataType.DataTypeFloat32);
        matrix.data.offset = 13 * floatSize;
        matrix.data.writeFloat(det * b42, DataType.DataTypeFloat32);
        matrix.data.offset = 14 * floatSize;
        matrix.data.writeFloat(det * b43, DataType.DataTypeFloat32);
        matrix.data.offset = 15 * floatSize;
        matrix.data.writeFloat(det * b44, DataType.DataTypeFloat32);

        matrix.data.offset = oldOffset;
    }

    static public function getDeterminant(matrix: Matrix4): Float
    {
        var oldOffset: Int = matrix.data.offset;

        matrix.data.offset = 0 * floatSize;
        var a11: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 1 * floatSize;
        var a12: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 2 * floatSize;
        var a13: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 3 * floatSize;
        var a14: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 4 * floatSize;
        var a21: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 5 * floatSize;
        var a22: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 6 * floatSize;
        var a23: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 7 * floatSize;
        var a24: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 8 * floatSize;
        var a31: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 9 * floatSize;
        var a32: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 10 * floatSize;
        var a33: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 11 * floatSize;
        var a34: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 12 * floatSize;
        var a41: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 13 * floatSize;
        var a42: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 14 * floatSize;
        var a43: Float = matrix.data.readFloat(DataType.DataTypeFloat32);
        matrix.data.offset = 15 * floatSize;
        var a44: Float = matrix.data.readFloat(DataType.DataTypeFloat32);

        matrix.data.offset = oldOffset;

        return (a11 * a22 * a33 * a44) + (a11 * a23 * a34 * a42) + (a11 * a24 * a32 * a43)
        + (a12 * a21 * a34 * a43) + (a12 * a23 * a31 * a44) + (a12 * a24 * a33 * a41)
        + (a13 * a21 * a32 * a44) + (a13 * a22 * a34 * a41) + (a13 * a24 * a31 * a42)
        + (a14 * a21 * a33 * a42) + (a14 * a22 * a31 * a43) + (a14 * a23 * a32 * a41)
        - (a11 * a22 * a34 * a43) - (a11 * a23 * a32 * a44) - (a11 * a24 * a33 * a42)
        - (a12 * a21 * a33 * a44) - (a12 * a23 * a34 * a41) - (a12 * a24 * a31 * a43)
        - (a13 * a21 * a34 * a42) - (a13 * a22 * a31 * a44) - (a13 * a24 * a32 * a41)
        - (a14 * a21 * a32 * a43) - (a14 * a22 * a33 * a41) - (a14 * a23 * a31 * a42);
    }
}