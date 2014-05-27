/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 27/05/14
 * Time: 11:37
 */
package types;
class SizeI
{
    public var width (get, set) : Int;
    public var height (get, set) : Int;

    private var _width : Int;
    private var _height : Int;

    public function new(width : Int = 0, height : Int = 0) : Void
    {
        setWidthAndHeight(width, height);
    }

    public inline function setWidthAndHeight(width : Int, height : Int) : Void
    {
        set_width(width);
        set_height(height);
    }

    private inline function set_width(width : Int) : Int
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


    private inline function set_height(height : Int) : Int
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

    private inline function get_width() : Int
    {
        return _width;
    }

    private inline function get_height() : Int
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