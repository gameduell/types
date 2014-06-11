package js.html;

/// Only UTF-8 encoding supported, which means that all encoding parameters are removed.
/// There are other features on the lib, but we only include the ones which we need.
/// If you need something else, use untyped __js__

@:native("StringView")
extern class StringView extends ArrayBufferView implements ArrayAccess<Int>
{
	static inline var BYTES_PER_ELEMENT : Int = 1; /// UTF-8

	var length(default,null) : Int;

	///just the string data
	var rawData(default, null) : js.html.Uint8Array;

	///the whole buffer
	var bufferView(default, null) : js.html.Uint8Array;

	@:overload( function( length : Int ) : Void {} )
	@:overload( function( array : Array<Int> ) : Void {} )
	@:overload( function( str : String ) : Void {} )
	function new( buffer : ArrayBuffer, ?encoding : String, ?byteOffset : Int, ?length : Int ) : Void;

	function subview( start : Int, ?end : Int ) : StringView;

	function toString() : String;
}