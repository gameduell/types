/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 06/06/14
 * Time: 20:21
 */
package types.haxeinterop;

import haxe.io.Error;
import js.html.Uint8Array;
import js.html.ArrayBuffer;

import js.html.StringView;
import haxe.io.BytesData;
import haxe.io.Bytes;
import types.Data;

using types.DataStringTools;


enum Seek {
    SeekEnd;
    SeekCur;
    SeekBegin;
}

@:access(haxe.io.Bytes)
class ArrayBufferBytes {
    public var length(default,null) : Int;
    var b : Uint8Array;

    public function new(length,b) {
        this.length = length;
        this.b = b;
    }

    public inline function get( pos : Int ) : Int {
        return b[pos];
    }

    public inline function set( pos : Int, v : Int ) : Void {
        b[pos] = v & 0xFF;
    }

    public function blit( pos : Int, src : Bytes, srcpos : Int, len : Int ) : Void {
		if( pos < 0 || srcpos < 0 || len < 0 || pos + len > length || srcpos + len > src.length ) throw Error.OutsideBounds;

        var b1 = b;
        var b2 = src.b;
        if( b1 == (cast b2) && pos > srcpos ) {
            var i = len;
            while( i > 0 ) {
                i--;
                b1[i + pos] = b2[i + srcpos];
            }
            return;
        }
        for( i in 0...len )
            b1[i+pos] = b2[i+srcpos];
    }

    public function fill( pos : Int, len : Int, value : Int ) {
        for( i in 0...len )
            set(pos++, value);
    }

    public function sub( pos : Int, len : Int ) : Bytes {
		if( pos < 0 || len < 0 || pos + len > length ) throw Error.OutsideBounds;
        var newArrayBuffer = new ArrayBuffer(len);
        var newView = new Uint8Array(newArrayBuffer);
        newView.set(b, 0);
        return cast new ArrayBufferBytes(len, newView);
    }

    public function compare( other : Bytes ) : Int {
        var b1 = b;
        var b2 = other.b;
        var len = (length < other.length) ? length : other.length;
        for( i in 0...len )
            if( b1[i] != b2[i] )
                return untyped b1[i] - untyped b2[i];
        return length - other.length;
    }

    public function getDouble( pos : Int ) : Float {
        var b = new haxe.io.BytesInput(cast this,pos,8);
        return b.readDouble();
    }

    public function getFloat( pos : Int ) : Float {
        var b = new haxe.io.BytesInput(cast this,pos,4);
        return b.readFloat();
    }

    public function setDouble( pos : Int, v : Float ) : Void {
        throw "Not supported";
    }

    public function setFloat( pos : Int, v : Float ) : Void {
        throw "Not supported";
    }

    public function getString( pos : Int, len : Int ) : String {
		if( pos < 0 || len < 0 || pos + len > length ) throw Error.OutsideBounds;
        var s = "";
        var b = b;
        var fcc = String.fromCharCode;
        var i = pos;
        var max = pos+len;
// utf8-decode and utf16-encode
        while( i < max ) {
            var c = b[i++];
            if( c < 0x80 ) {
                if( c == 0 ) break;
                s += fcc(c);
            } else if( c < 0xE0 )
                s += fcc( ((c & 0x3F) << 6) | (b[i++] & 0x7F) );
            else if( c < 0xF0 ) {
                var c2 = b[i++];
                s += fcc( ((c & 0x1F) << 12) | ((c2 & 0x7F) << 6) | (b[i++] & 0x7F) );
            } else {
                var c2 = b[i++];
                var c3 = b[i++];
                var u = ((c & 0x0F) << 18) | ((c2 & 0x7F) << 12) | ((c3 & 0x7F) << 6) | (b[i++] & 0x7F);
// surrogate pair
                s += fcc( (u >> 10) + 0xD7C0 );
                s += fcc( (u & 0x3FF) | 0xDC00 );
            }
        }
        return s;
    }

    @:deprecated("readString is deprecated, use getString instead")
    @:noCompletion
    public inline function readString(pos:Int, len:Int):String {
        return getString(pos, len);
    }

    public function toString() : String {
        return getString(0,length);
    }

    public function toHex() : String {
        var s = new StringBuf();
        var chars = [];
        var str = "0123456789abcdef";
        for( i in 0...str.length )
            chars.push(str.charCodeAt(i));
        for( i in 0...length ) {
            var c = get(i);
            s.addChar(chars[c >> 4]);
            s.addChar(chars[c & 15]);
        }
        return s.toString();
    }

    public inline function getData() : BytesData {
        return cast b;
    }

    public static function alloc( length : Int ) : Bytes {
        var a = new ArrayBuffer(length);
        return cast new ArrayBufferBytes(length, new Uint8Array(a));
    }

    public static function ofString( s : String ) : Bytes {

        var a = new ArrayBuffer(s.sizeInBytes());

        var stringView = new StringView(s);
        var view =  new Uint8Array(a);
        view.set(stringView.rawData, 0);
        return cast new ArrayBufferBytes(a.byteLength, view);
    }

    public static function ofData( b : BytesData ) {

        var a = new ArrayBuffer(b.length);
        var view =  new Uint8Array(a);

        for(i in 0...b.length)
        {
            view[i] = b[i];
        }
        return new ArrayBufferBytes(a.byteLength, view);
    }

    public inline static function fastGet( b : BytesData, pos : Int ) : Int {
        return b[pos];
    }

}

@:access(haxe.io.Bytes)
class DataBytesTools {
    public static function getBytes(data:Data):Bytes {
        var existingBuffer : ArrayBuffer = data.arrayBuffer;
        var slicedBuffer = existingBuffer.slice(data.offset, data.offset + data.offsetLength);
        return cast new ArrayBufferBytes(data.offsetLength, new Uint8Array(slicedBuffer));
    }

    public static function getTypesData(bytes : Bytes) : Data {

        var d = new Data(bytes.length);
        var stream = new HaxeOutputInteropStream(new DataOutputStream(d));
        stream.writeBytes(bytes, 0, bytes.length);

        return d;
    }
}