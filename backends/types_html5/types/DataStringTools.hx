package types;

import js.html.StringView;

class DataStringTools {

	public static function readString(data : Data) : String 
	{ 
		if(data.stringView != null)
			return new StringView(data.arrayBuffer, "UTF-8", data.offset, data.offsetLength).toString();
		else
			return "";
	}

	public static function writeString(data : Data, string : String) : Void 
	{
		var stringView = new StringView(string);
		data.uint8Array.set(stringView.rawData, data.offset);
	}

	public static function sizeInBytes(string : String) 
	{    
		var byteLen = 0;

    	for(i in 0...string.length) 
    	{
       		var c = string.charCodeAt(i);
        	byteLen += c < (1 <<  7) ? 1 :
	                   c < (1 << 11) ? 2 :
	                   c < (1 << 16) ? 3 :
	                   c < (1 << 21) ? 4 :
	                   c < (1 << 26) ? 5 :
	                   c < (1 << 31) ? 6 : 0;
    	}

    	return byteLen;
	}

}