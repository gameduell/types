import types.haxeinterop.HaxeInputInteropStream;

import unittest.TestRunner;
import unittest.implementations.TestHTTPLogger;
import unittest.implementations.TestJUnitLogger;  
import unittest.implementations.TestSimpleLogger;   

import DataTest;
import Matrix4Test;
import Vector2Test;
import Vector4Test;
import SizeTest;
import AffineTransformTest;
import Color4BTest;
import StreamTest;
import HaxeInteropTest;

import duell.DuellKit;

class MainTester
{
    static var r : TestRunner;
	static function main() : Void 
	{
		DuellKit.initialize(start);
	}

	static function start()
	{
		r = new TestRunner(testComplete);
		r.add(new DataTest());
		r.add(new Matrix4Test());
        r.add(new Vector2Test());
        r.add(new Vector4Test());
        r.add(new SizeTest());
        r.add(new AffineTransformTest());
        r.add(new Color4BTest());
        r.add(new StreamTest());
        r.add(new HaxeInteropTest());

        #if test
        r.addLogger(new TestHTTPLogger(new TestJUnitLogger()));
        #else
        r.addLogger(new TestSimpleLogger());
        #end

		r.run();
	}

    static function testComplete()
    {
        trace(r.result);
    }
}