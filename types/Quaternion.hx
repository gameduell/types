package types;

class Quaternion
{
    public var x: Float = 0.0;
    public var y: Float = 0.0;
    public var z: Float = 0.0;
    public var w: Float = 0.0;

    public function new(x: Float = 0.0, y: Float = 0.0, z: Float = 0.0, w: Float = 1.0)
    {
        setXYZW(x,y,z,w);
    }

    public function setIdentity(): Void
    {
        x = 0.0;
        y = 0.0;
        z = 0.0;
        w = 1.0;
    }

    public function setXYZW(x: Float, y: Float, z: Float, w: Float): Void
    {
        this.x = x;
        this.y = y;
        this.z = z;
        this.w = w;
    }

    public function setOther(quaternion: Quaternion): Void
    {
        x = quaternion.x;
        y = quaternion.y;
        z = quaternion.z;
        w = quaternion.w;
    }

    // Order is XYZ
    public function setFromEuler(euler: Vector3): Void
    {
        var c1 = Math.cos(euler.x / 2.0);
        var c2 = Math.cos(euler.y / 2.0);
        var c3 = Math.cos(euler.z / 2.0);
        var s1 = Math.sin(euler.x / 2.0);
        var s2 = Math.sin(euler.y / 2.0);
        var s3 = Math.sin(euler.z / 2.0);

        x = s1 * c2 * c3 + c1 * s2 * s3;
        y = c1 * s2 * c3 - s1 * c2 * s3;
        z = c1 * c2 * s3 + s1 * s2 * c3;
        w = c1 * c2 * c3 - s1 * s2 * s3;
    }

    // Assumes axis is normalized
    public function setFromAxisAngle(axis: Vector3, angle: Float): Void
    {
        var halfAngle: Float = angle * 0.5;
        var s: Float = Math.sin(halfAngle);

        x = axis.x * s;
        y = axis.y * s;
        z = axis.z * s;
        w = Math.cos(halfAngle);
    }

    // TODO implement in QuaternionMatrix3Tools
    /*

    public function setFromRotationMatrix(matrix: Matrix3): Void

    setFromRotationMatrix: function ( m ) {

		// http://www.euclideanspace.com/maths/geometry/rotations/conversions/matrixToQuaternion/index.htm

		// assumes the upper 3x3 of m is a pure rotation matrix (i.e, unscaled)

		var te = m.elements,

			m11 = te[ 0 ], m12 = te[ 4 ], m13 = te[ 8 ],
			m21 = te[ 1 ], m22 = te[ 5 ], m23 = te[ 9 ],
			m31 = te[ 2 ], m32 = te[ 6 ], m33 = te[ 10 ],

			trace = m11 + m22 + m33,
			s;

		if ( trace > 0 ) {

			s = 0.5 / Math.sqrt( trace + 1.0 );

			this._w = 0.25 / s;
			this._x = ( m32 - m23 ) * s;
			this._y = ( m13 - m31 ) * s;
			this._z = ( m21 - m12 ) * s;

		} else if ( m11 > m22 && m11 > m33 ) {

			s = 2.0 * Math.sqrt( 1.0 + m11 - m22 - m33 );

			this._w = ( m32 - m23 ) / s;
			this._x = 0.25 * s;
			this._y = ( m12 + m21 ) / s;
			this._z = ( m13 + m31 ) / s;

		} else if ( m22 > m33 ) {

			s = 2.0 * Math.sqrt( 1.0 + m22 - m11 - m33 );

			this._w = ( m13 - m31 ) / s;
			this._x = ( m12 + m21 ) / s;
			this._y = 0.25 * s;
			this._z = ( m23 + m32 ) / s;

		} else {

			s = 2.0 * Math.sqrt( 1.0 + m33 - m11 - m22 );

			this._w = ( m21 - m12 ) / s;
			this._x = ( m13 + m31 ) / s;
			this._y = ( m23 + m32 ) / s;
			this._z = 0.25 * s;

		}

		this.onChangeCallback();

		return this;

	},

     */

    public function inverse(): Void
    {
        conjugate();
        normalize();
    }

    public function conjugate(): Void
    {
        x *= -1.0;
        y *= -1.0;
        z *= -1.0;
    }

    public function normalize(): Void
    {
        var length: Float = Quaternion.length(this);

        if (length == 0.0)
        {
            setIdentity();
        }
        else
        {
            multiplyScalar(1.0 / length);
        }
    }

    static public function dotProduct(left: Quaternion, right: Quaternion): Float
    {
        return left.x * right.x + left.y * right.y + left.z * right.z + left.w * right.w;
    }

    static public function length(quaternion: Quaternion) : Float
    {
        return Math.sqrt(Quaternion.lengthSquared(quaternion));
    }

    static public function lengthSquared(quaternion: Quaternion) : Float
    {
        return quaternion.x * quaternion.x + quaternion.y * quaternion.y + quaternion.z * quaternion.z + quaternion.w * quaternion.w;
    }

    public function multiply(q: Quaternion): Void
    {
        multiplyQuaternions(this, q);
    }

    // Multiplies two quaternions and stores the result in this
    public function multiplyQuaternions(left: Quaternion, right: Quaternion): Void
    {
        // from http://www.euclideanspace.com/maths/algebra/realNormedAlgebra/quaternions/code/index.htm

        var qax = left.x, qay = left.y, qaz = left.z, qaw = left.w;
        var qbx = right.x, qby = right.y, qbz = right.z, qbw = right.w;

        x = qax * qbw + qaw * qbx + qay * qbz - qaz * qby;
        y = qay * qbw + qaw * qby + qaz * qbx - qax * qbz;
        z = qaz * qbw + qaw * qbz + qax * qby - qay * qbx;
        w = qaw * qbw - qax * qbx - qay * qby - qaz * qbz;
    }

    public function add(quaternion: Quaternion): Void
    {
        x += quaternion.x;
        y += quaternion.y;
        z += quaternion.z;
        w += quaternion.w;
    }

    public function multiplyScalar(scalar: Float): Void
    {
        x *= scalar;
        y *= scalar;
        z *= scalar;
        w *= scalar;
    }

    public function isEqual(q: Quaternion): Bool
    {
        return q.x == x && q.y == y && q.z == z && q.w == w;
    }

    static public function slerp(qa: Quaternion, qb: Quaternion, qout: Quaternion, t: Float): Void
    {
        qout.setOther(qa);

        if (t == 0.0)
        {
            return;
        }
        if (t == 1.0)
        {
            qout.setOther(qb);
            return;
        }

        var x = qout.x, y = qout.y, z = qout.z, w = qout.w;

        var cosHalfTheta = w * qb.w + x * qb.x + y * qb.y + z * qb.z;

        if (cosHalfTheta < 0.0)
        {
            qout.w = -qb.w;
            qout.x = -qb.x;
            qout.y = -qb.y;
            qout.z = -qb.z;

            cosHalfTheta = -cosHalfTheta;
        }
        else
        {
            qout.setOther(qb);
        }

        if (cosHalfTheta >= 1.0)
        {
            qout.w = w;
            qout.x = x;
            qout.y = y;
            qout.z = z;

            return;
        }

        var halfTheta = Math.acos(cosHalfTheta);
        var sinHalfTheta = Math.sqrt(1.0 - cosHalfTheta * cosHalfTheta);

        if (Math.abs(sinHalfTheta) < 0.001)
        {
            qout.w = 0.5 * (w + qout.w);
            qout.x = 0.5 * (x + qout.x);
            qout.y = 0.5 * (y + qout.y);
            qout.z = 0.5 * (z + qout.z);

            return;
        }

        var ratioA = Math.sin((1 - t) * halfTheta) / sinHalfTheta;
        var ratioB = Math.sin(t * halfTheta) / sinHalfTheta;

        qout.w = (w * ratioA + qout.w * ratioB);
        qout.x = (x * ratioA + qout.x * ratioB);
        qout.y = (y * ratioA + qout.y * ratioB);
        qout.z = (z * ratioA + qout.z * ratioB);
    }

}
