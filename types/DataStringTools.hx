package types;

extern class DataStringTools {

	public static function sizeInBytes(string : String) : Int;

	public static function createStringFromData(data : Data) : String;

	public static function setString(data : Data, string : String) : Void {}; 
}