package types;

@:cppFileCode('

#ifndef HX_UTF8_STRINGS
	#error UNSUPPORTED
#endif
namespace hx{
	HX_CHAR *NewString(int inLen);
}
')

class DataStringTools {

	@:functionCode('

		int len = data->_nativeData->offsetLength;
		HX_CHAR *result = hx::NewString(len);
		memcpy(result, (char*)data->_nativeData->ptr + data->_nativeData->offset, sizeof(HX_CHAR)*(len));
		return ::String(result, len);
	')
	public static function createStringFromData(data : Data) : String { return ""; }

	@:functionCode('
		const char* c = string.c_str();
		data->_nativeData->writePointer(c, string.length);
	')
	public static function setString(data : Data, string : String) : Void {}; 

	@:functionCode('
		return string.length;
	')
	public static function sizeInBytes(string : String) { return 0; }

}