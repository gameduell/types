package types;

import types.Data;

extern Class Matrix4
{
	public function new() : Void;

	public static function identity() : Matrix4;
	
	public static function createOrtho( x0 : Float, 
										x1 : Float, 
										y0 : Float, 
										y1 : Float, 
										zNear : Float, 
										zFar : Float) : Matrix4;

	public function setOrtho(	x0 : Float, 
								x1 : Float, 
								y0 : Float, 
								y1 : Float, 
								zNear : Float, 
								zFar : Float) : Void;

	public static function create2D(posX : Float, 
									posY : Float, 
									scale : Float, 
									rotation : Float) : Matrix4;

	public function set2D(	posX : Float, 
							posY : Float, 
							scale : Float, 
							rotation : Float) : Void;

	public static function createBymultiplication(left : Matrix4, right : Matrix4) : Matrix4;

	public function multiply(right : Matrix4) : Void;

	public function toString() : String;

	public var data(default, null) : Data;

}