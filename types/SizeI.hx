/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 27/05/14
 * Time: 11:37
 */
package types;
class SizeI
{
    public var width(default, set): Int = 0;
    public var height(default, set): Int = 0;

    public function new() : Void
    {
    }

    private inline function set_width(value: Int): Int
    {
        width = value;
        return value;
    }

    private inline function set_height(value: Int): Int
    {
        height = value;
        return value;
    }

    public inline function flip(): Void
    {
        var temp = width;
        width = height;
        height = temp;
    }

    public function toString() : String
    {
        return "Width: " + width + " Height: " + height;
    }
}