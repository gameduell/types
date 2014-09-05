package types;

enum TouchState
{
	TouchStateBegan;
	TouchStateMoved;
	TouchStateStationary;
	TouchStateEnded;
}

class Touch
{
    public var id(default, null) : Int; 
    public var x(default, null) : Int;
    public var y(default, null) : Int;
    public var state(default, null) : TouchState;
    public var timestamp(default, null) : Float;

    public function new() 
    {
    	id = 0;
    	x = 0;
    	y = 0;
    	state = TouchStateBegan;
    	timestamp = 0.0;
    };
}