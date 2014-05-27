
import lime.Lime;

import DataTest;
import Matrix4Test;
import SizeTest;
import UGridSizeTest;
import AffineTransformTest;
import Color4BTest;

class MainTester 
{
	public function new() {};

	public function ready (lime:Lime) : Void 
	{
		var r = new haxe.unit.TestRunner();
		r.add(new DataTest());
		r.add(new Matrix4Test());
        r.add(new SizeTest());
        r.add(new UGridSizeTest());
        r.add(new AffineTransformTest());
        r.add(new Color4BTest());

		r.run();
		trace(r.result.toString());
	}
}