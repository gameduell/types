package types;

extern class DataStringTools {

	public static function sizeInBytes(string : String) : Int;

	public static function readString(data : Data) : String;

	public static function writeString(data : Data, string : String) : Void {}; 
}