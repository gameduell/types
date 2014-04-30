import types.Size;

import TestHelper;

class SizeTest extends haxe.unit.TestCase
{
    private function assertSize(_width : Float, _height : Float, _size : Size)
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
        var size = new Size();
        assertSize(0.0,0.0,size);
    }

    public function testCreationWithValue()
    {
        var size = new Size(4.23, 5.67);
        assertSize(4.23,5.67,size);
    }

    public function testAssignment()
    {
        var size = new Size();
        size.width = 4.23;
        size.height = 5.67;
        assertSize(4.23,5.67,size);
    }

    public function testFlip()
    {
        var size = new Size(4.23, 5.67);
        size.flip();
        assertSize(5.67,4.23,size);
    }

}