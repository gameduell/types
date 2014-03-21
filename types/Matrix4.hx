package types;

import types.Data;

extern Class Matrix4
{
	public function new() : Void;

	public function setIdentity() : Matrix4;

	public function setOrtho(	x0 : Float, 
								x1 : Float, 
								y0 : Float, 
								y1 : Float, 
								zNear : Float, 
								zFar : Float) : Void;

	public function set2D(	posX : Float, 
							posY : Float, 
							scale : Float, 
							rotation : Float) : Void;

	public function set(other : Matrix4);

	public function multiply(right : Matrix4) : Void;

	public function toString() : String;

	public var data(default, null) : Data;

}