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

@:access(haxe.io.Bytes)
class DataBytesTools {
    public static function getBytes(data:Data):Bytes {
        var bytes = new Bytes(data.arrayBuffer);
        return bytes;
    }

    public static function getTypesData(bytes : Bytes) : Data {

        var data = new Data(0);

        data.arrayBuffer = bytes.b.buffer;

        return data;
    }
}
