package types;

import types.Data;

extern class Matrix4
{
	public function new(): Void;

	public function setIdentity(): Void;

	public function setOrtho(left: Float,
							right: Float,
	 					   bottom: Float,
							  top: Float,
						    zNear: Float,
							 zFar: Float): Void;

	public function set2D(posX: Float,
						  posY: Float,
						  scale: Float,
						  rotation: Float): Void;

	public function set(other: Matrix4): Void;

	public function get(row: Int, col: Int): Float;

	public function multiply(right: Matrix4): Void;

	public function toString(): String;

	public var data(default, null): Data;
}