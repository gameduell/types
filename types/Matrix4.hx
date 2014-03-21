package types;

import types.Data;


class Matrix4
{
	public var data(default, null) : Data;

	public function new() : Void{

	}

	public function initDataWithMatrixPointer() 
	{

	}

	public function setIdentity() : Void 
	{

	}

	public function setOrtho(	x0 : Float, 
								x1 : Float, 
								y0 : Float, 
								y1 : Float, 
								zNear : Float, 
								zFar : Float) : Void 
	{

	}

	public function set2D(	posX : Float, 
							posY : Float, 
							scale : Float, 
							rotation : Float) : Void 
	{ 

	}

	public function set(matrix : Matrix4) : Void 
	{ 

	}

	public function multiply(right : Matrix4) : Void 
	{ 

	}

	public function toString() : String 
	{ 
		return ""; 
	}


}