package types;

import types.Data;

extern class Vector4
{
    public function new(_data : Data = null, _dataOffset : Int = 0) : Void;

/// Vector Interface

    public var x(get, set) : Float;
    public var y(get, set) : Float;
    public var z(get, set) : Float;
    public var w(get, set) : Float;

/// Color Interface

    public var r(get, set) : Float;
    public var g(get, set) : Float;
    public var b(get, set) : Float;
    public var a(get, set) : Float;

/// Setters & Getters

    public function setXYZW(_x : Float, _y : Float, _z : Float, _w : Float) : Void;
    public function setRGBA(_r : Float, _g : Float, _b : Float, _a : Float) : Void;
    public function set(other : Vector4) : Void;

    public function get(index : Int) : Float;

/// Math

    public function negate() : Void;

    public function add(right : Vector4) : Void;
    public function subtract(right : Vector4) : Void;
    public function multiply(right : Vector4) : Void;
    public function divide(right : Vector4) : Void;

    public function addScalar(value : Float) : Void;
    public function subtractScalar(value : Float) : Void;
    public function multiplyScalar(value : Float) : Void;
    public function divideScalar(value : Float) : Void;

    public function normalize() : Void;
    public function lerp(start : Vector4, end : Vector4, t : Float) : Void;

    public static function length(vector : Vector4) : Float;
    public static function lengthSquared(vector : Vector4) : Float;
    public static function distance(start : Vector4, end : Vector4) : Float;

    public function toString() : String;

    public var data(default, null) : Data;
    public var dataOffset(default, null) : Int;
}