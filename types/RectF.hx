package types;

class RectF extends Vector4
{
    public var width(get, set): Float;
    public var height(get, set): Float;

    private inline function set_width(width: Float): Float
    {
        z = width;
        return z;
    }

    private inline function set_height(height: Float): Float
    {
        w = height;
        return w;
    }

    private inline function get_width(): Float
    {
        return z;
    }

    private inline function get_height(): Float
    {
        return w;
    }
}