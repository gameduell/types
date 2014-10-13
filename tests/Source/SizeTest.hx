import types.SizeF;
import types.SizeI;

import TestHelper;

class SizeTest extends unittest.TestCase
{
    private function assertSizeF(_width : Float, _height : Float, _size : SizeF)
    {
        var failed = false;

        if (!TestHelper.nearlyEqual(_width, _size.width))
        {
            failed = true;
        }

        if (!TestHelper.nearlyEqual(_height, _size.height))
        {
            failed = true;
        }

        if(failed == true)
        {
            trace("Comparison Failed, expected: " + "Width: " + _width + " Height: " + _height + " and got: " + _size.toString());
            assertTrue(false);
        }
        assertTrue(true);
    }

    private function assertSizeI(_width : Int, _height : Int, _size : SizeI)
    {
        var failed = false;

        if (!TestHelper.nearlyEqual(_width, _size.width))
        {
            failed = true;
        }

        if (!TestHelper.nearlyEqual(_height, _size.height))
        {
            failed = true;
        }

        if(failed == true)
        {
            trace("Comparison Failed, expected: " + "Width: " + _width + " Height: " + _height + " and got: " + _size.toString());
            assertTrue(false);
        }
        assertTrue(true);
    }

    public function testCreation()
    {
        var sizef = new SizeF();
        assertSizeF(0.0, 0.0, sizef);

        var sizei = new SizeI();
        assertSizeI(0, 0, sizei);
    }

    public function testCreationWithValue()
    {
        var sizef = new SizeF(4.23, 5.67);
        assertSizeF(4.23, 5.67, sizef);

        var sizei = new SizeI(4, 5);
        assertSizeI(4, 5, sizei);
    }

    public function testAssignment()
    {
        var sizef = new SizeF();
        sizef.width = 4.23;
        sizef.height = 5.67;
        assertSizeF(4.23,5.67,sizef);

        var sizei = new SizeI();
        sizei.width = 4;
        sizei.height = 5;
        assertSizeI(4, 5, sizei);
    }

    public function testFlip()
    {
        var sizef = new SizeF(4.23, 5.67);
        sizef.flip();
        assertSizeF(5.67, 4.23, sizef);

        var sizei = new SizeI(4, 5);
        sizei.flip();
        assertSizeI(5, 4, sizei);
    }

    public function testSetNegativeValues()
    {
        var sizef = new SizeF();
        sizef.width = -4000.12;
        sizef.height = -50.123;
        assertSizeF(0, 0,sizef);

        var sizei = new SizeI();
        sizei.width = -4000;
        sizei.height = -50;
        assertSizeI(0, 0,sizei);
    }

}