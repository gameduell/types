import types.Vector4;

import TestHelper;

class Vector4Test extends unittest.TestCase
{
    private function assertVector4(floatArray : Array<Float>, vector4 : Vector4)
    {
        var failed = false;

        for(i in 0...floatArray.length)
        {
            var f = floatArray[i];
            var fInVector4 = vector4.get(i);

            if(!TestHelper.nearlyEqual(f, fInVector4))
            {
                failed = true;
                break;
            }
        }
        if(failed == true)
        {
            trace("Comparison Failed, expected: " + floatArray.toString() + " and got: " + vector4.toString());
            assertTrue(false);
        }
        assertTrue(true);
    }

    public function testCreation()
    {
        var vec1 = new Vector4();
        assertVector4([0.0, 0.0, 0.0, 0.0], vec1);
    }

    public function testSet()
    {
        var vec1 = new Vector4();
        vec1.setXYZW(23.0,42.0,21.0,9.0);

        assertVector4([23.0,42.0,21.0,9.0], vec1);

        var vec2 = new Vector4();
        vec2.set(vec1);

        assertVector4([23.0,42.0,21.0,9.0], vec2);

        vec1.setRGBA(vec2.r, vec2.g, vec2.b, vec2.a);

        assertVector4([23.0,42.0,21.0,9.0], vec1);

        vec2.x = 5.0;
        vec2.y = 8.0;
        vec2.z = 13.0;
        vec2.w = 21.0;

        assertVector4([5.0, 8.0, 13.0, 21.0], vec2);
    }

    public function testGet()
    {
        var vec1 = new Vector4();
        vec1.setXYZW(23.0,42.0,21.0,9.0);

        var vec2 = new Vector4();
        vec2.x = vec1.x;
        vec2.y = vec1.y;
        vec2.z = vec1.z;
        vec2.w = vec1.w;

        assertVector4([23.0,42.0,21.0,9.0], vec2);
    }

    public function testNegation() : Void
    {
        var vec1 = new Vector4();
        vec1.setXYZW(23.0,42.0,21.0,9.0);

        vec1.negate();

        assertVector4([-23.0,-42.0,-21.0,-9.0], vec1);
    }

    public function testAddition() : Void
    {
        var vec1 = new Vector4();
        vec1.setXYZW(23.0,42.0,21.0,9.0);

        var vec2 = new Vector4();
        vec2.set(vec1);

        vec1.add(vec2);

        assertVector4([2.0*23.0,2.0*42.0,2.0*21.0,2.0*9.0], vec1);
    }


    public function testSubtraction() : Void
    {
        var vec1 = new Vector4();
        vec1.setXYZW(23.0,42.0,21.0,9.0);

        var vec2 = new Vector4();
        vec2.set(vec1);

        vec1.subtract(vec2);

        assertVector4([0.0, 0.0, 0.0, 0.0], vec1);
    }

    public function testMultiplication() : Void
    {
        var vec1 = new Vector4();
        vec1.setXYZW(23.0,42.0,21.0,9.0);

        var vec2 = new Vector4();
        vec2.set(vec1);

        vec1.multiply(vec2);

        assertVector4([529.0, 1764.0, 441.0, 81.0], vec1);
    }

    public function testDivision() : Void
    {
        var vec1 = new Vector4();
        vec1.setXYZW(23.0,42.0,21.0,9.0);

        var vec2 = new Vector4();
        vec2.setXYZW(23.0,2.0,7.0,4.5);

        vec1.divide(vec2);

        assertVector4([1.0, 21.0, 3.0, 2.0], vec1);
    }

    public function testAdditionScalar() : Void
    {
        var vec1 = new Vector4();
        vec1.setXYZW(23.0,42.0,21.0,9.0);

        vec1.addScalar(5.5);

        assertVector4([23.0+5.5, 42.0+5.5, 21.0+5.5, 9.0+5.5], vec1);
    }

    public function testSubtractionScalar() : Void
    {
        var vec1 = new Vector4();
        vec1.setXYZW(23.0,42.0,21.0,9.0);

        vec1.subtractScalar(5.5);

        assertVector4([23.0-5.5, 42.0-5.5, 21.0-5.5, 9.0-5.5], vec1);
    }

    public function testMultiplicationScalar() : Void
    {
        var vec1 = new Vector4();
        vec1.setXYZW(23.0,42.0,21.0,9.0);

        vec1.multiplyScalar(5.5);

        assertVector4([23.0*5.5, 42.0*5.5, 21.0*5.5, 9.0*5.5], vec1);
    }

    public function testDivisionScalar() : Void
    {
        var vec1 = new Vector4();
        vec1.setXYZW(23.0,42.0,21.0,9.0);

        vec1.divideScalar(5.5);

        assertVector4([23.0/5.5, 42.0/5.5, 21.0/5.5, 9.0/5.5], vec1);
    }

    public function testNormalization() : Void
    {
        var vec1 = new Vector4();
        vec1.setXYZW(23.0,42.0,21.0,9.0);

        vec1.normalize();

        var scale:Float = 1.0 / Math.sqrt(23.0*23.0 + 42.0*42.0 + 21.0*21.0 + 9.0*9.0);
        var x:Float = scale * 23.0;
        var y:Float = scale * 42.0;
        var z:Float = scale * 21.0;
        var w:Float = scale * 9.0;

        assertVector4([x, y, z, w], vec1);
    }

    public function testLerp() : Void
    {
        var vec1 = new Vector4();

        var lerpStart = new Vector4();
        var lerpEnd = new Vector4();

        lerpStart.setXYZW(20.0,20.0,20.0,1.0);
        lerpEnd.setXYZW(60.0,60.0,60.0,0.0);

        vec1.lerp(lerpStart, lerpEnd, 0.5);

        assertVector4([40.0, 40.0, 40.0, 0.5], vec1);
    }

    public function testLength() : Void
    {
        var vec1 = new Vector4();
        vec1.setXYZW(23.0,42.0,21.0,9.0);

        var length = Vector4.length(vec1);
        var test = Math.sqrt(23.0*23.0 + 42.0*42.0 + 21.0*21.0 + 9.0*9.0);

        if (!TestHelper.nearlyEqual(length, test))
        {
            trace("Comparison Failed, expected: " + test + " and got: " + length);
            assertTrue(false);
        }

        assertTrue(true);
    }

    public function testLengthSquared() : Void
    {
        var vec1 = new Vector4();
        vec1.setXYZW(23.0,42.0,21.0,9.0);

        var length = Vector4.lengthSquared(vec1);
        var test = 23.0*23.0 + 42.0*42.0 + 21.0*21.0 + 9.0*9.0;

        if (!TestHelper.nearlyEqual(length, test))
        {
            trace("Comparison Failed, expected: " + test + " and got: " + length);
            assertTrue(false);
        }

        assertTrue(true);
    }

    public function testDistance() : Void
    {
        var vec1 = new Vector4();
        vec1.setXYZW(5.0,5.0,5.0,0.0);

        var vec2 = new Vector4();
        vec2.setXYZW(3.0,3.0,3.0,0.0);

        var distance = Vector4.distance(vec1, vec2);

        vec1.subtract(vec2);
        var test = Vector4.length(vec1);

        if (!TestHelper.nearlyEqual(distance, test))
        {
            trace("Comparison Failed, expected: " + test + " and got: " + distance);
            assertTrue(false);
        }

        assertTrue(true);
    }

}
