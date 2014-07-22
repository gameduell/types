import types.haxeinterop.HaxeInputInteropStream;
import platform.AppMain;

import DataTest;
import Matrix4Test;
import Vector2Test;
import Vector4Test;
import SizeTest;
import AffineTransformTest;
import Color4BTest;
import StreamTest;
import HaxeInteropTest;


class MainTester extends AppMain
{
	override function start() : Void 
	{
        var a :Array<Int>;
		var r = new haxe.unit.TestRunner();
		r.add(new DataTest());
		r.add(new Matrix4Test());
        r.add(new Vector2Test());
        r.add(new Vector4Test());
        r.add(new SizeTest());
        r.add(new AffineTransformTest());
        r.add(new Color4BTest());
        r.add(new StreamTest());
        r.add(new HaxeInteropTest());

		r.run();
	}

}