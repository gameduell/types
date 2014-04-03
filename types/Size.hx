/*
 * Created by IntelliJ IDEA.
 * User: sott
 * Date: 14/03/14
 * Time: 11:33
 */
package types;

class Size
{
    public var width : Float = 0.0;
    public var height : Float = 0.0;

    public function new(_width : Float = 0, _height : Float = 0) : Void
    {
        width = _width;
        height = _height;
    }

    public inline function flip()
    {
        var temp = width;
        width = height;
        height = temp;
    }

    public function toString() : String
    {
        return "Width: " +  width + " Height: " + height;
    }

}