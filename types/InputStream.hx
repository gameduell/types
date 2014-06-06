/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 05/06/14
 * Time: 15:43
 */
package types;

interface InputStream
{
    public function readInt(targetDataType : DataType) : Int;

    public function readFloat(targetDataType : DataType) : Float;

    public function readIntArray(count : Int, targetDataType : DataType) : Array<Int>;

    public function readFloatArray(count : Int, targetDataType : DataType) : Array<Float>;

    public function readString(byteCount : Int) : String;

    public function readIntoData(data : Data) : Void;

    public function available() : Bool;

    public function skip(byteCount : Int) : Void;

    public function close() : Void;
}