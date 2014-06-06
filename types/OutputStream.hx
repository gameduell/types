/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 05/06/14
 * Time: 15:44
 */
package types;

interface OutputStream
{
    public function available() : Bool;

    public function writeData(data : Data) : Void;

    public function writeInt(value : Int, targetDataType : DataType) : Void;

    public function writeFloat(value : Float, targetDataType : DataType) : Void;

    public function writeIntArray(array : Array<Int>, dataType : DataType) : Void;

    public function writeFloatArray(array : Array<Float>, dataType : DataType) : Void;

    public function writeString(string : String) : Void;

    public function close() : Void;
}