package types;

extern class DataStringTools {

	public static function createStringFromData(data : Data, ?encoding : DataStringEncoding) : String;

	public static function setString(data : Data, string : String, ?encoding : DataStringEncoding) : Void {}; 
}