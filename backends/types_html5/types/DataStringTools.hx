/*
 * Copyright (c) 2003-2015, GameDuell GmbH
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

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
