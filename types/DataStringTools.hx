package types;

@:cppFileCode('


template<typename T>
char *TConvertToUTF8(T *inStr, int *ioLen);

')

class DataStringTools {

	@:functionCode('


		#ifdef HX_UTF8_STRINGS

			if(encoding == 0)
				encoding = ::types::DataStringEncoding_obj::DataStringEncodingUTF8;

			switch( (int)(encoding->__Index())){
				case (int)0: {
					return ::String((char*)data->_nativeData->ptr + data->_nativeData->offset, data->_nativeData->offsetLength);
				}
				case (int)1: {

					///result is GCed
   					char *result = TConvertToUTF8((uint8_t*)data->_nativeData->ptr + data->_nativeData->offset,&data->_nativeData->offsetLength);
					return ::String(result, data->_nativeData->offsetLength);
				}
			}
		#else
			#error UNSUPORTED
		#endif
	')
	public static function createStringFromData(data : Data, ?encoding : DataStringEncoding) : String { return ""; }

	@:functionCode('
		if(encoding == 0)
			encoding = ::types::DataStringEncoding_obj::DataStringEncodingUTF8;

		switch( (int)(encoding->__Index())){
			case (int)0: {
				#ifdef HX_UTF8_STRINGS
					int scale = 1;
				#else
					#error UNSUPORTED
				#endif
				const char* c = string.c_str();
				data->_nativeData->writePointer(c, string.length * scale);

				break;
			}
			case (int)1: {
				#ifdef HX_UTF8_STRINGS
					int scale = 2;
				#else
					#error UNSUPORTED
				#endif
				const wchar_t* c = string.__WCStr();
				data->_nativeData->writePointer(c, string.length * scale);
				
				break;
			}
		}
	')
	public static function setString(data : Data, string : String, ?encoding : DataStringEncoding) : Void {}; 

}