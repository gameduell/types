package types;

import types.Data;

extern class Vector2
{
    public function new(_data : Data = null, _dataOffset : Int = 0) : Void;

/// Vector Interface

    public var x(get, set) : Float;
    public var y(get, set) : Float;

/// Texture Coordinate Interface

    public var s(get, set) : Float;
    public var t(get, set) : Float;

/// Setters & Getters

    public function setXY(_x : Float, _y : Float) : Void;
    public function setST(_s : Float, _t : Float) : Void;
    public function set(other : Vector2) : Void;

    public function get(index : Int) : Float;

/// Math

    public function negate() : Void;

    public function add(right : Vector2) : Void;
    public function subtract(right : Vector2) : Void;
    public function multiply(right : Vector2) : Void;
    public function divide(right : Vector2) : Void;

    public function addScalar(value : Float) : Void;
    public function subtractScalar(value : Float) : Void;
    public function multiplyScalar(value : Float) : Void;
    public function divideScalar(value : Float) : Void;

    public function normalize() : Void;
    public function lerp(start : Vector2, end : Vector2, t : Float) : Void;

    public static function length(vector : Vector2) : Float;
    public static function lengthSquared(vector : Vector2) : Float;
    public static function distance(start : Vector2, end : Vector2) : Float;

    public function toString() : String;

    public var data(default, null) : Data;
    public var dataOffset(default, null) : Int;
}
