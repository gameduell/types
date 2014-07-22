import types.AffineTransformMatrix4Tools;
import types.AffineTransform;
import types.Matrix4;

import TestHelper;

using types.AffineTransformMatrix4Tools;

class AffineTransformTest extends haxe.unit.TestCase
{
    private function assertAffineTransform(floatArray : Array<Float>, affineTransform : AffineTransform)
    {
        var failed = false;

        for(i in 0...floatArray.length)
        {
            var f = floatArray[i];
            var fInAffineTransform = affineTransform.get(i);

            if(!TestHelper.nearlyEqual(f, fInAffineTransform))
            {
                failed = true;
                break;
            }
        }
        if(failed == true)
        {
            trace("Comparison Failed, expected: " + floatArray.toString() + " and got: " + affineTransform.toString());
            assertTrue(false);
        }
        assertTrue(true);
    }

    public function testCreation()
    {
        var aTransform = new AffineTransform();
        assertAffineTransform([0, 0, 0, 0, 0, 0], aTransform);
    }

    public function testIdentity()
    {
        var aTransform = new AffineTransform();
        aTransform.setIdentity();
        assertAffineTransform([1, 0, 0, 1, 0, 0], aTransform);
    }

    public function testSet()
    {
        var aTransform = new AffineTransform();

        aTransform.a = 0.0;
        aTransform.b = 0.0;
        aTransform.c = 0.0;
        aTransform.d = 0.0;
        aTransform.tx = 42.0;
        aTransform.ty = 24.0;

        assertAffineTransform([0, 0, 0, 0, 42, 24], aTransform);

        var bTransform = new AffineTransform();

        bTransform.set(aTransform);
        assertAffineTransform([0, 0, 0, 0, 42, 24], bTransform);
    }

    public function testSetFromMatrix4()
    {
        var aMatrix = new Matrix4();
        aMatrix.set2D(42,24,1,0);

        var aTransform = new AffineTransform();
        aTransform.setFromMatrix4(aMatrix);

        assertAffineTransform([1, 0, 0, 1, 42, 24], aTransform);
    }

    public function testTranslate()
    {
        var aTransform = new AffineTransform();
        aTransform.setIdentity();

        aTransform.translate(42, 24);
        assertAffineTransform([1, 0, 0, 1, 42, 24], aTransform);
    }

    public function testScale()
    {
        var aTransform = new AffineTransform();
        aTransform.setIdentity();

        aTransform.scale(2,2);
        assertAffineTransform([2, 0, 0, 2, 0, 0], aTransform);
    }

    public function testRotation()
    {
        var aTransform = new AffineTransform();
        aTransform.setIdentity();

        aTransform.rotate(Math.PI);
        assertAffineTransform([-1, 0, 0, -1, 0, 0], aTransform);

        aTransform.rotate(Math.PI/2);
        assertAffineTransform([0, -1, 1, 0, 0, 0], aTransform);

        aTransform.rotate(Math.PI/2);
        assertAffineTransform([1, 0, 0, 1, 0, 0], aTransform);
    }

    public function testConcat()
    {
        var aTransform = new AffineTransform();
        aTransform.setIdentity();
        aTransform.translate(42,24);

        var bTransform = new AffineTransform();
        bTransform.setIdentity();
        bTransform.scale(2,2);

        bTransform.concat(aTransform);
        assertAffineTransform([2, 0, 0, 2, 42, 24], bTransform);
    }

    public function testInvert()
    {
        var aTransform = new AffineTransform();
        aTransform.setIdentity();
        aTransform.translate(42, 24);

        aTransform.invert();

        assertAffineTransform([1, 0, 0, 1, -42, -24], aTransform);
    }

}
