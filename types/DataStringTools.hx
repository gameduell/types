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


		if(encoding == 0)
			encoding = ::types::DataStringEncoding_obj::DataStringEncodingUTF8;

		switch( (int)(encoding->__Index())){
			case (int)0: {
				int len = data->_nativeData->offsetLength;
				HX_CHAR *result = hx::NewString(len);
				memcpy(result, (char*)data->_nativeData->ptr + data->_nativeData->offset, sizeof(HX_CHAR)*(len));
				return ::String(result, len);
			}
		}
	')
	public static function createStringFromData(data : Data, ?encoding : DataStringEncoding) : String { return ""; }

	@:functionCode('
		if(encoding == 0)
			encoding = ::types::DataStringEncoding_obj::DataStringEncodingUTF8;

		switch( (int)(encoding->__Index())){
			case (int)0: {
				const char* c = string.c_str();
				data->_nativeData->writePointer(c, string.length);

				break;
			}
		}
	')
	public static function setString(data : Data, string : String, ?encoding : DataStringEncoding) : Void {}; 

}