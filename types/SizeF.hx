/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 27/05/14
 * Time: 11:37
 */
package types;

class SizeF extends Vector2
{
    public var width(get, set): Float;
    public var height(get, set): Float;

    private inline function set_width(width: Float): Float
    {
        x = width;
        return x;
    }

    private inline function set_height(height: Float): Float
    {
        y = height;
        return y;
    }

    private inline function get_width(): Float
    {
        return x;
    }

    private inline function get_height(): Float
    {
        return y;
    }

    public inline function flip(): Float
    {
        var temp = x;
        x = y;
        y = temp;
    }

    public function toString(): String
    {
        return "Width: " + x + " Height: " + y;
    }


}