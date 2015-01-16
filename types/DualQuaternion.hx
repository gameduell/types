package types;

import types.DualQuaternion;
class DualQuaternion
{
    public var real(default, null): Quaternion = null;
    public var dual(default, null): Quaternion = null;

    static private var workingVectorA: Vector3 = new Vector3();
    static private var workingVectorB: Vector3 = new Vector3();
    static private var workingVectorC: Vector3 = new Vector3();
    static private var workingQuaternionA: Quaternion = new Quaternion();
    static private var workingQuaternionB: Quaternion = new Quaternion();
    static private var workingQuaternionC: Quaternion = new Quaternion();
    static private var workingDualQuaternionA: DualQuaternion = new DualQuaternion();
    static private var workingDualQuaternionB: DualQuaternion = new DualQuaternion();
    static private var workingDualQuaternionC: DualQuaternion = new DualQuaternion();

    public function new()
    {
        real = new Quaternion(0.0, 0.0, 0.0, 1.0);
        dual = new Quaternion(0.0, 0.0, 0.0, 0.0);
    }

    public function setOther(other: DualQuaternion): Void
    {
        real.setOther(other.real.normalize());
        dual.setOther(other.dual);
    }

    public function setFromQuaternions(real: Quaternion, dual: Quaternion): Void
    {
        real.setOther(real.normalize());
        dual.setOther(dual);
    }

    public function setIdentity(): Void
    {
        real.setIdentity();
        dual.setXYZW(0.0, 0.0, 0.0, 0.0);
    }

    public function setPositionAndRotation(position: Vector3, quaternion: Quaternion): Void
    {
        real.setOther(quaternion.normalize());

        dual.setXYZW(position.x, position.y, position.z, 0.0);
        dual.multiply(real);
        dual.multiplyScalar(0.5);
    }

    public function setPosition(position: Vector3): Void
    {
        real.setIdentity();

        dual.setXYZW(position.x, position.y, position.z, 0.0);
        dual.multiply(real);
        dual.multiplyScalar(0.5);
    }

    public function setRotation(quaternion: Quaternion): Void
    {
        real.setOther(quaternion.normalize());
        dual.setXYZW(0.0, 0.0, 0.0, 0.0);
    }

    public function setRotationX(angle: Float): Void
    {
        setRotation(workingQuaternionA.setFromAxisAngle(workingVectorA.setXYZ(1.0, 0.0, 0.0), angle));
    }

    public function setRotationY(angle: Float): Void
    {
        setRotation(workingQuaternionA.setFromAxisAngle(workingVectorA.setXYZ(0.0, 1.0, 0.0), angle));
    }

    public function setRotationZ(angle: Float): Void
    {
        setRotation(workingQuaternionA.setFromAxisAngle(workingVectorA.setXYZ(0.0, 0.0, 1.0), angle));
    }

    public function getRotation(): Quaternion
    {
        return real;
    }

    public function getEulerRotation(out: Vector3): Void
    {
        var ex: Float;
        var ey: Float;
        var ez: Float;

        var r: Quaternion = real;
        var x: Float = r.x;
        var y: Float = r.y;
        var z: Float = r.z;
        var w: Float = r.w;

        var sqw = w * w;
        var sqx = x * x;
        var sqy = y * y;
        var sqz = z * z;
        var unit = sqx + sqy + sqz + sqw; // if normalized is one, otherwise is correction factor

        var test = x * y + z * w;

        if (test > 0.499 * unit) // singularity at north pole
        {
            ey = 2 * Math.atan2( x, w );
            ez = Math.PI * 0.5;
            ex = 0;
        }
        else if (test < - 0.499 * unit) // singularity at south pole
        {
            ey = -2 * Math.atan2( x, w );
            ez = -Math.PI * 0.5;
            ex = 0;
        }
        else
        {
            ey = Math.atan2( 2 * y * w - 2 * x * z, sqx - sqy - sqz + sqw );
            ez = Math.asin( 2 * test / unit );
            ex = Math.atan2( 2 * x * w - 2 * y * z, -sqx + sqy - sqz + sqw );
        }

        out.setXYZ(ex, ey, ez);
    }

    public function getTranslation(out: Vector3): Void
    {
        workingQuaternionB.setOther(dual);
        workingQuaternionC.setOther(real);
        workingQuaternionA.multiplyQuaternions(workingQuaternionB.multiplyScalar(2.0), workingQuaternionC.conjugate());
        out.x = workingQuaternionA.x;
        out.y = workingQuaternionA.y;
        out.z = workingQuaternionA.z;
    }

    public function setTranslation(translation: Vector3): Void
    {
        dual.multiplyQuaternions(workingQuaternionA.setXYZW(translation.x, translation.y, translation.z, 0.0), real);
        dual.multiplyScalar(0.5);
    }

    public function multiplyScalar(scalar: Float): Void
    {
        real.multiplyScalar(scalar);
        real.normalize();
        dual.multiplyScalar(scalar);
    }

    public function multiply(q: DualQuaternion): Void
    {
        multiplyDualQuaternions(this, q);
    }

    // Multiplies two dual quaternions and stores the result in this
    public function multiplyDualQuaternions(q1: DualQuaternion, q2: DualQuaternion): Void
    {
        workingDualQuaternionA.setOther(q1);
        workingDualQuaternionB.setOther(q2);

        workingDualQuaternionA.normalize();
        workingDualQuaternionB.normalize();

        real.multiplyQuaternions(workingDualQuaternionA.real, workingDualQuaternionB.real);
        real.normalize();

        dual.multiplyQuaternions(workingDualQuaternionA.real, workingDualQuaternionB.dual);
        dual.add(workingQuaternionA.multiplyQuaternions(workingDualQuaternionA.dual, workingDualQuaternionB.real));
    }

    public function setFromAxisAngleAndTranslation(axis: Vector3, angle: Float, translation: Vector3): Void
    {
        real.setFromAxisAngle(axis, angle);
        real.normalize();

        dual.setXYZW(translation.x, translation.y, translation.z, 0.0);
        dual.multiply(real);
        dual.multiplyScalar(0.5);
    }

    public function setFromEulerAndTranslation(euler: Vector3, translation: Vector3): Void
    {
        real.setFromEuler(euler);
        real.normalize();

        dual.setXYZW(translation.x, translation.y, translation.z, 0.0);
        dual.multiply(real);
        dual.multiplyScalar(0.5);
    }

    public function normalize(): Void
    {
        var n: Float = 1.0 / Quaternion.length(real);
        real.multiplyScalar(n);
        dual.multiplyScalar(n);
    }

    public function conjugate(): Void
    {
        real.conjugate();
        dual.conjugate();
    }

    static public function dotProduct(left: DualQuaternion, right: DualQuaternion): Void
    {
        return Quaternion.dotProduct(left.real, right.real);
    }

    static public function sclerp(qa: DualQuaternion, qb: DualQuaternion, qout: DualQuaternion, t: Float): Void
    {
        var dot: Float = DualQuaternion.dotProduct(qa, qb);

        workingDualQuaternionA.setOther(qa);
        workingDualQuaternionA.conjugate();

        if (dot < 0.0)
        {
            workingDualQuaternionB.setOther(qb);
            workingDualQuaternionB.multiplyScalar(-1.0);
        }

        // diff
        workingDualQuaternionC.multiplyDualQuaternions(workingDualQuaternionA, workingDualQuaternionB);

        // vr
        workingVectorA.setXYZ(workingDualQuaternionC.real.x, workingDualQuaternionC.real.y, workingDualQuaternionC.real.z);
        // vd
        workingVectorB.setXYZ(workingDualQuaternionC.dual.x, workingDualQuaternionC.dual.y, workingDualQuaternionC.dual.z);

        var invr: Float = 1.0 / Math.sqrt(Vector3.lengthSquared(workingVectorA));

        var angle: Float = 2.0 * Math.acos(workingDualQuaternionC.real.w);
        var pitch: Float =-2.0 * workingDualQuaternionC.dual.w * invr;

        // direction
        workingVectorC.set(workingVectorA);
        workingVectorC.multiplyScalar(invr);

        // Reuse vr for Moment
        workingVectorA.set(workingVectorB);

        // Temp use of vd
        workingVectorB.set(workingVectorC);
        workingVectorB.multiplyScalar(pitch * workingDualQuaternionC.real.w * 0.5);
        workingVectorA.subtract(workingVectorB);

        workingVectorA.multiplyScalar(invr);

        angle *= t;
        pitch *= t;

        var sinAngle: Float = Math.sin(0.5 * angle);
        var cosAngle: Float = Math.cos(0.5 * angle);

        // We just need direction and moment from here

        // v
        workingVectorB.set(workingVectorC);
        workingVectorB.multiplyScalar(sinAngle);

        // real
        workingDualQuaternionC.real.setXYZW(workingVectorB.x, workingVectorB.y, workingVectorB.z, cosAngle);

        workingVectorA.multiplyScalar(sinAngle);
        workingVectorC.multiplyScalar(pitch * 0.5 * cosAngle);
        workingVectorA.add(workingVectorC);

        // dual
        workingDualQuaternionC.dual.setXYZW(workingVectorA.x, workingVectorA.y, workingVectorA.z, -pitch * 0.5 * sinAngle);

        qout.multiplyDualQuaternions(qa, workingDualQuaternionC);
    }
}
