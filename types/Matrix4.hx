package types;

import types.Data;

@:headerClassCode('					
public:								
	float matrix[4][4];				
') 
class Matrix4
{
	public function new() : Void
	{
		data = new Data(0);
	}

	public static function identity() : Matrix4 { return new Matrix4(); };
	
	public static function createOrtho( x0 : Float, 
										x1 : Float, 
										y0 : Float, 
										y1 : Float, 
										zNear : Float, 
										zFar : Float) : Matrix4 { return new Matrix4(); }

	public function setOrtho(	x0 : Float, 
								x1 : Float, 
								y0 : Float, 
								y1 : Float, 
								zNear : Float, 
								zFar : Float) : Void { }

	public static function create2D(posX : Float, 
									posY : Float, 
									scale : Float, 
									rotation : Float) : Matrix4 { return new Matrix4(); }

	public function set2D(	posX : Float, 
							posY : Float, 
							scale : Float, 
							rotation : Float) : Void { }

	public static function createBymultiplication(left : Matrix4, right : Matrix4) : Matrix4 { return new Matrix4(); }

	public function multiply(right : Matrix4) : Void { }

	@:functionCode('
		std::wostringstream oss;

		oss << "[";

		for(int i = 0; i < 4; ++i)
		{
			oss << matrix[i][0];
			for(int j = 1; j < 4; ++j)
			{
				oss << ", ";
				oss << matrix[i][j];
			}

			if(i < 3)
				oss << ", ";
		}

		oss << "]";

		std::wstring str = oss.str();
		
		return ::String(str.c_str(), str.size() + 1);
	') 
	public function toString() : String { return ""; }

	public var data(default, null) : Data;

}