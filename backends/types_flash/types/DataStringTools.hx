package types;
import types.Data;

@:access(types.Data)
class DataStringTools
{
    public static function sizeInBytes(string : String) : Int
    {
        var byteLen = 0;

        for(i in 0...string.length)
        {
            var c = string.charCodeAt(i);
            byteLen += c < (1 <<  7) ? 1 :
            c < (1 << 11) ? 2 :
            c < (1 << 16) ? 3 :
            c < (1 << 21) ? 4 :
            c < (1 << 26) ? 5 :
            c < (1 << 31) ? 6 : 0;
        }

        return byteLen;
    }

    public static function readString(data : Data) : String
    {
        data.setByteArrayPositionLazily();
        var string:String = data.byteArray.readUTFBytes(data.offsetLength);
        data._internalByteArrayOffset += data.offsetLength;
        return string;
    }

    public static function writeString(data : Data, string : String) : Void
    {
        data.setByteArrayPositionLazily();
        data.byteArray.writeUTFBytes(string);
        data._internalByteArrayOffset += sizeInBytes(string);
    }
}