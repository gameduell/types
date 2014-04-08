package types;

import types.Data;
import types.DataType;


class Matrix4
{
	public var data(default, null) : Data;

	private static var identity : Data;

	public function new() : Void{
		data = new Data(4*4*4);
	}

	public function setIdentity() : Void 
	{
		if(identity == null)
		{
			identity = new Data(4*4*4);
			identity.setFloatArray([1.0, 0.0, 0.0, 0.0,
								    0.0, 1.0, 0.0, 0.0,
								    0.0, 0.0, 1.0, 0.0,
								    0.0, 0.0, 0.0, 1.0], DataTypeFloat);
		}
		data.setData(identity);
	}

	public function setOrtho(	x0 : Float, 
								x1 : Float, 
								y0 : Float, 
								y1 : Float, 
								zNear : Float, 
								zFar : Float) : Void 
	{
		var floatView = data.float32Array;

    	var ral = x1 + x0;
    	var rsl = x1 - x0;
    	var tab = y1 + y0;
    	var tsb = y1 - y0;
    	var fan = zFar + zNear;
    	var fsn = zFar - zNear;

    	floatView[0] = 2.0 / rsl;
    	floatView[1] = 0.0;
    	floatView[2] = 0.0;
    	floatView[3] = 0.0;
    	floatView[4] = 0.0;
    	floatView[5] = 2.0 / tsb;
    	floatView[6] = 0.0;
    	floatView[7] = 0.0;
    	floatView[8] = 0.0;
    	floatView[9] = 0.0;
    	floatView[10] = -2.0 / fsn;
    	floatView[11] = 0.0;
    	floatView[12] = -ral / rsl;
    	floatView[13] = -tab / tsb;
    	floatView[14] = -fan / fsn;
    	floatView[15] = 1.0;
	}

	public function set2D(	posX : Float, 
							posY : Float, 
							scale : Float, 
							rotation : Float) : Void 
	{ 
		var floatView = data.float32Array;

		var theta = rotation * Math.PI / 180.0;
      	var c = Math.cos(theta);
      	var s = Math.sin(theta);

    	floatView[0] = c * scale;
    	floatView[1] = -s * scale;
    	floatView[2] = 0.0;
    	floatView[3] = 0.0;
    	floatView[4] = s * scale;
    	floatView[5] = c * scale;
    	floatView[6] = 0.0;
    	floatView[7] = 0.0;
    	floatView[8] = 0.0;
    	floatView[10] = 1.0;
    	floatView[11] = 0.0;
    	floatView[12] = posX;
    	floatView[13] = posY;
    	floatView[14] = 0.0;
    	floatView[15] = 1.0;
	}

	public function set(matrix : Matrix4) : Void 
	{ 
		data.setData(matrix.data);
	}

	public function get(row : Int, col : Int) : Float
	{
		return data.float32Array[row * 4 + col];
	}

	public function multiply(right : Matrix4) : Void 
	{ 
		var a = data.float32Array;
		var b = right.data.float32Array;
		var out = data.float32Array;
   		var a00 = a[0], a01 = a[1], a02 = a[2], a03 = a[3],
        	a10 = a[4], a11 = a[5], a12 = a[6], a13 = a[7],
       		a20 = a[8], a21 = a[9], a22 = a[10], a23 = a[11],
        	a30 = a[12], a31 = a[13], a32 = a[14], a33 = a[15];

	    // Cache only the current line of the second matrix
	    var b0  = b[0], b1 = b[1], b2 = b[2], b3 = b[3];  
	    	out[0] = b0*a00 + b1*a10 + b2*a20 + b3*a30;
	    	out[1] = b0*a01 + b1*a11 + b2*a21 + b3*a31;
	    	out[2] = b0*a02 + b1*a12 + b2*a22 + b3*a32;
	    	out[3] = b0*a03 + b1*a13 + b2*a23 + b3*a33;

	    b0 = b[4]; b1 = b[5]; b2 = b[6]; b3 = b[7];
	    out[4] = b0*a00 + b1*a10 + b2*a20 + b3*a30;
	    out[5] = b0*a01 + b1*a11 + b2*a21 + b3*a31;
	    out[6] = b0*a02 + b1*a12 + b2*a22 + b3*a32;
	    out[7] = b0*a03 + b1*a13 + b2*a23 + b3*a33;

	    b0 = b[8]; b1 = b[9]; b2 = b[10]; b3 = b[11];
	    out[8] = b0*a00 + b1*a10 + b2*a20 + b3*a30;
	    out[9] = b0*a01 + b1*a11 + b2*a21 + b3*a31;
	    out[10] = b0*a02 + b1*a12 + b2*a22 + b3*a32;
	    out[11] = b0*a03 + b1*a13 + b2*a23 + b3*a33;

	    b0 = b[12]; b1 = b[13]; b2 = b[14]; b3 = b[15];
	    out[12] = b0*a00 + b1*a10 + b2*a20 + b3*a30;
	    out[13] = b0*a01 + b1*a11 + b2*a21 + b3*a31;
	    out[14] = b0*a02 + b1*a12 + b2*a22 + b3*a32;
	    out[15] = b0*a03 + b1*a13 + b2*a23 + b3*a33;
	}

	public function toString() : String
	{ 
		var output = "";
		output += "[";

		var view = data.float32Array;
		output += view[0];

		for(i in 1...16)
		{
			output += ", ";
			output += view[i];
		}

		output += "]";
		return output;
	}


}