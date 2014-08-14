import types.AffineTransformMatrix4Tools;
import types.Matrix4;

import types.AffineTransform;

import types.DataType;

import TestHelper;

using types.AffineTransformMatrix4Tools;

class Matrix4Test extends haxe.unit.TestCase
{
    private function assertMatrix4(floatArray : Array<Float>, matrix : Matrix4)
    {
        var failed = false;
        for(i in 0...floatArray.length)
        {
            var f = floatArray[i];
            var row : Int = Math.floor(i / 4);
            var col : Int = i % 4;
            var fInMatrix = matrix.get(row, col);
            if(!TestHelper.nearlyEqual(f, fInMatrix))
            {
                failed = true;
                break;
            }
        }
        if(failed == true)
        {
            trace("Comparison Failed, expected: " + floatArray.toString() + " and got: " + matrix.toString());
            assertTrue(false);
        }
        assertTrue(true);
    }
    
    public function testCreation()
    {
    	var matrix = new Matrix4();
        assertMatrix4([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], matrix);
    }
    
    public function testIdentity()
    {
    	var matrix = new Matrix4();
        matrix.setIdentity();
        assertMatrix4([1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1], matrix);
    }

    public function testCreationOrtho()
    {
        var matrix = new Matrix4();
    	matrix.setOrtho(0, 1024, 1024, 0, -1024, 1024);
        assertMatrix4([0.00195312, 0, 0, -1, 0, -0.00195312, 0, 1, 0, 0, -0.000488281, 0.5, 0, 0, 0, 1], matrix);
    }

    public function testSet2D()
    {
    	var matrix = new Matrix4();
    	matrix.set2D(123.45, 543.21, 2.5, 30.0);

        assertMatrix4([2.16506, 1.25, 0, 123.45, -1.25, 2.16506, 0, 543.21, 0, 0, 1, 0, 0, 0, 0, 1], matrix);
    }

    public function testMultiply()
    {
    	var first = new Matrix4();
        first.set2D(123.45, 543.21, 1, 0);

    	var second = new Matrix4();
        second.set2D(0, 0, 2.5, 0);

    	var third = new Matrix4();
        third.set2D(0, 0, 1, 30.0);

    	second.multiply(third);
        assertMatrix4([2.16506, 1.25, 0, 0, -1.25, 2.16506, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1], second);

    	first.multiply(second);
        assertMatrix4([2.16506, 1.25, 0, 946.29, -1.25, 2.16506, 0, 1021.77, 0, 0, 1, 0, 0, 0, 0, 1], first);
    }

    public function testSet()
    {
        var matrix1 = new Matrix4();
        matrix1.set2D(123.45, 543.21, 2.5, 30.0);

        var matrix2 = new Matrix4();
        matrix2.set(matrix1);
        assertMatrix4([2.16506, 1.25, 0, 123.45, -1.25, 2.16506, 0, 543.21, 0, 0, 1, 0, 0, 0, 0, 1], matrix2);
    }

    public function testSetFromAffineTransform()
    {
        var affineTransform = new AffineTransform();
        affineTransform.setIdentity();
        affineTransform.translate(42, 24);

        var matrix = new Matrix4();
        matrix.setFromAffineTransform(affineTransform);

        assertMatrix4([1, 0, 0, 42, 0, 1, 0, 24, 0, 0, 1, 0, 0, 0, 0, 1], matrix);
    }

}