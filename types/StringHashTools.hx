/*
 * Created by IntelliJ IDEA.
 * User: sott
 * Date: 07/07/14
 * Time: 16:49
 */
package types;

class StringHashTools
{
    static public function getFnv32Int(string:String) : Int
    {
        var hash:Int = 0;

        for (i in 0...string.length)
        {
            hash *= 16777619;
            hash ^= string.charCodeAt(i);
        }

        return hash;
    }
}