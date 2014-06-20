package types;

import types.Data;

extern class Vector3
{
    public function new(_data : Data = null, _dataOffset : Int = 0) : Void;

    public var data(default, null) : Data;
    public var dataOffset(default, null) : Int;
}