/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 06/06/14
 * Time: 20:09
 */
package types;
import haxe.io.Bytes;
import haxe.io.Input;

class HaxeInputInteropStream extends Input
{
    private var inputStream : InputStream;
    public function new(newInputStream : InputStream)
    {
        inputStream = newInputStream;
    }


    public function readByte() : Int {

    }

    public function readBytes( s : Bytes, pos : Int, len : Int ) : Int {

    }

    public function close() {
        inputStream.close();
    }

    public function readAll( ?bufsize : Int ) : Bytes {
        if( bufsize == null )
            bufsize = (1 << 14); // 16 Ko

        var buf = Bytes.alloc(bufsize);
        var total = new haxe.io.BytesBuffer();
        try {
            while( true ) {
                var len = readBytes(buf,0,bufsize);
                if( len == 0 )
                    throw Error.Blocked;
                total.addBytes(buf,0,len);
            }
        } catch( e : Eof ) {
        }
        return total.getBytes();
    }

    public function readFullBytes( s : Bytes, pos : Int, len : Int ) {
    }

    public function read( nbytes : Int ) : Bytes {
    }

    public function readUntil( end : Int ) : String {
    }

    public function readLine() : String {
    }

    public function readFloat() : Float {
    }

    public function readDouble() : Float {
    }

    public function readInt8() {
    }

    public function readInt16() {
    }

    public function readUInt16() {
    }

    public function readInt24() {
    }

    public function readUInt24() {
    }

    public function readInt32() {
    }

    public function readString( len : Int ) : String {
    }


}