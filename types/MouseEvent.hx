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
