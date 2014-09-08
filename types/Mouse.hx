package types;

enum MouseButtonState
{
    MouseButtonStateDown;
    MouseButtonStateUp;
}

enum MouseButton
{
	MouseButtonLeft;
	MouseButtonRight;
	MouseButtonMiddle;
	MouseButtonOther(name : String);
}

typedef MouseButtonEvent =
{
	var button : MouseButton;
	var newState : MouseButtonState; 
}

typedef MouseMovementEvent =
{
	var deltaX : Float;
	var deltaY : Float; 
}

class Mouse
{
	/// at runtime, a mouse lib can add more buttons here.
	public var states (default, null) : Map<MouseButton, MouseButtonState>;

	private function new()
	{
		states = [
			MouseButtonLeft => MouseButtonStateUp,
			MouseButtonRight => MouseButtonStateUp,
			MouseButtonMiddle => MouseButtonStateUp
		];
	}

	private static var mouses : Map<String, Mouse> = [ "__MAIN__" => new Mouse() ];
	public static function getMouse(mouseIdentifier : String = "__MAIN__") : Mouse
	{
		if (!mouses.exists(mouseIdentifier))
		{
			mouses[mouseIdentifier] = new Mouse();
		}

		return mouses[mouseIdentifier];
	}

	public static function getMouses() : Iterator<String>
	{
		return mouses.keys();
	}

	public static function addMouse(str : String) : Void
	{
		mouses[str] = new Mouse();
	}
}