/*
 * Created by IntelliJ IDEA.
 * User: sott
 * Date: 03/04/14
 * Time: 12:46
 */

class TestHelper
{
    public static var EPSILON : Float = 0.00001;
    public static function nearlyEqual(a : Float, b : Float) : Bool
    {
        var absA = Math.abs(a);
        var absB = Math.abs(b);
        var diff = Math.abs(a - b);

        if (a == b)
        { // shortcut, handles infinities
            return true;
        }
        else if (a * b == 0)
        { // a or b or both are zero
            // relative error is not meaningful here
            return diff < (EPSILON * EPSILON);
        }
        else
        { // use relative error
            return diff / (absA + absB) < EPSILON;
        }
    }
}