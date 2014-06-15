/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 27/05/14
 * Time: 11:37
 */
package types;
class SizeF
{
    public var width (get, set) : Float;
    public var height (get, set) : Float;

    private var _width : Float;
    private var _height : Float;

    public function new(width : Float = 0, height : Float = 0) : Void
    {
        setWidthAndHeight(width, height);
    }

    public inline function setWidthAndHeight(width : Float, height : Float) : Void
    {
        set_width(width);
        set_height(height);
    }

    private inline function set_width(width : Float) : Float
    {
        if (width < 0)
        {
            _width = 0;
        }
        else
        {
            _width = width;
        }

        return width;
    }


    private inline function set_height(height : Float) : Float
    {
        if (height < 0)
        {
            _height = 0;
        }
        else
        {
            _height = height;
        }

        return height;
    }

    private inline function get_width() : Float
    {
        return _width;
    }

    private inline function get_height() : Float
    {
        return _height;
    }

    public inline function flip()
    {
        var temp = width;
        width = height;
        height = temp;
    }

    public function toString() : String
    {
        return "Width: " + _width + " Height: " + _height;
    }


}