import platform.AppMain;

import DataTest;
import Matrix4Test;
import SizeTest;
import AffineTransformTest;
import Color4BTest;

class MainTester extends AppMain
{
	override function start() : Void 
	{
		var r = new haxe.unit.TestRunner();
		r.add(new DataTest());
		r.add(new Matrix4Test());
        r.add(new SizeTest());
        r.add(new AffineTransformTest());
        r.add(new Color4BTest());

		r.run();
		trace(r.result.toString());
	}
}