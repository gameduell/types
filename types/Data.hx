package types;

import types.DataType;

 class Data
{
	public var length(default, null) : Int;

	public function new(sizeInBytes : Int) : Void
	{
		length = sizeInBytes;
	}

	public function setData(data : Data, offsetInBytes : Int)
	{

	}

	public function setValue(value : Dynamic, offsetInBytes : Int, dataType : DataType)
	{

	}

	public function setArray(array : Array<Int>, offsetInBytes : Int, dataType : DataType)
	{

	}

	public function toString(?dataType : DataType) : String
	{
		return "Unimplemented";
	}

}
/*
// This is so the "FILE *" type is known to the compiler.  Other libraries  may require other includes. 
@:headerCode("#include <stdio.h>") 
// Define the GC finalizer for method 1 - code goes in the cpp file ..... 
@:cppFileCode('void staticClose(MyStdio_obj *inObj) { if (inObj->mFile)   
fclose(inObj->mFile); printf("CLOSED!\\n"); }\n') 
// Put a "FILE *" member in the class, as well as an inline function. 
// All members get "memset" to 0 on construction - no automatic destructor will get called... 
@:headerClassCode('FILE *mFile;\ninline static void Print() {   printf("PRINT!\\n"); }') 
class MyStdio 
{ 
    public function new() 
    { 
       // You can sometimes call/use the native members directly if the   usage matches standard 
       //  haxe usage.  Use the 'untyped' keyword so that the compiler does   not check 
       //  that MyStdio has a "Print" function. 
       untyped MyStdio.Print(); 
       // Can't do code-injection on constructor - must use separate   
function 
       setFinalizer(); 
    } 

    @:functionCode("hx::GCSetFinalizer(this, (hx::finalizer)staticClose);") 
    function setFinalizer() { } 

    @:functionCode('mFile=::fopen(filename.__s, mode.__s); return   mFile!=0;') 
    public function fopen(filename:String, mode:String)   { return false;  } 

    @:functionCode('return fwrite(inString.__s, inString.length, 1,   mFile);') 
    public function writeString(inString:String)  { return 0; } 

    @:functionCode('if (mFile) fclose(mFile); mFile=0;') 
    public function close() 
    { 
       // Ok to do memory operations here (not a native finalizer) 
       trace("Closed!"); 
    } 
} 
*/