package types;

import Data;

extern Class Matrix
{
	public function new() : Void;
	
	public static function createOrtho( x0 : Float, 
										x1 : Float, 
										y0 : Float, 
										y1 : Float, 
										zNear : Float, 
										zFar : Float) : Matrix;

	public function setOrtho(	x0 : Float, 
								x1 : Float, 
								y0 : Float, 
								y1 : Float, 
								zNear : Float, 
								zFar : Float) : Void;

	public static function create2D(posX : Float, 
									posY : Float, 
									scale : Float, 
									rotation : Float) : Matrix;

	public function set2D(	posX : Float, 
							posY : Float, 
							scale : Float, 
							rotation : Float) : Void;

	public static function createBymultiplication(left : Matrix, right : Matrix) : Matrix;

	public function multiply(right : Matrix) : Void;

	public var data(default, null) : Data;

}