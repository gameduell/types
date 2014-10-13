/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 27/05/14
 * Time: 10:29
 */

import types.Data;
import types.Color4B;

import types.DataType;

import TestHelper;


class Color4BTest extends unittest.TestCase
{
    private function assertColor4B(intArray : Array<Int>, color : Color4B)
    {
        assertEquals(intArray[0], color.r);
        assertEquals(intArray[1], color.g);
        assertEquals(intArray[2], color.b);
        assertEquals(intArray[3], color.a);
    }

    public function testCreation()
    {
        var color = new Color4B();
        assertColor4B([0, 0, 0, 0], color);
    }

    public function testSettingComponents()
    {
        var color = new Color4B();

        assertColor4B([0, 0, 0, 0], color);

        color.r = 123;

        assertColor4B([123, 0, 0, 0], color);

        color.g = 123;

        assertColor4B([123, 123, 0, 0], color);

        color.b = 123;

        assertColor4B([123, 123, 123, 0], color);

        color.a = 123;

        assertColor4B([123, 123, 123, 123], color);
    }

    public function testSettingComponentsBoundValues()
    {
        var color = new Color4B();

        assertColor4B([0, 0, 0, 0], color);

        color.r = 255;
        color.g = 256;
        color.b = 257;

        assertColor4B([255, 0, 1, 0], color);
    }
}