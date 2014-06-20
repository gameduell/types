package types;

import types.Data;

@:headerCode('
#include <hxMath.h>

#include <types/NativeData.h>


#ifdef __cplusplus
extern "C" {
#endif


union _UTKVector4
{
    struct
    {
        float x, y, z, w;
    };
    float v[4];
};
typedef union _UTKVector4 UTKVector4;



#if __APPLE__

#include <TargetConditionals.h>

#if TARGET_OS_MAC && !TARGET_OS_IPHONE
	#ifndef __SSE3__
		#warning "SSE3 instruction set not enabled. GLKit math routines will be slower."
	#else
		#include <immintrin.h>
		#include <stdint.h>
		#define GLK_SSE3_INTRINSICS 1
	#endif
#endif

#if defined(__ARM_NEON__)
	#include <arm_neon.h>
#endif

#endif



inline UTKVector4 UTKVector4Negate(UTKVector4 vector);

inline UTKVector4 UTKVector4Add(UTKVector4 vectorLeft, UTKVector4 vectorRight);
inline UTKVector4 UTKVector4Subtract(UTKVector4 vectorLeft, UTKVector4 vectorRight);
inline UTKVector4 UTKVector4Multiply(UTKVector4 vectorLeft, UTKVector4 vectorRight);
inline UTKVector4 UTKVector4Divide(UTKVector4 vectorLeft, UTKVector4 vectorRight);

inline UTKVector4 UTKVector4AddScalar(UTKVector4 vector, float value);
inline UTKVector4 UTKVector4SubtractScalar(UTKVector4 vector, float value);
inline UTKVector4 UTKVector4MultiplyScalar(UTKVector4 vector, float value);
inline UTKVector4 UTKVector4DivideScalar(UTKVector4 vector, float value);

inline UTKVector4 UTKVector4Normalize(UTKVector4 vector);

inline float UTKVector4DotProduct(UTKVector4 vectorLeft, UTKVector4 vectorRight);
inline float UTKVector4Length(UTKVector4 vector);
inline float UTKVector4Distance(UTKVector4 vectorStart, UTKVector4 vectorEnd);

inline UTKVector4 UTKVector4Lerp(UTKVector4 vectorStart, UTKVector4 vectorEnd, float t);




inline UTKVector4 UTKVector4Negate(UTKVector4 vector)
{
#if defined(__ARM_NEON__)
    float32x4_t v = vnegq_f32(*(float32x4_t *)&vector);
    return *(UTKVector4 *)&v;
#else
    UTKVector4 v = { -vector.v[0], -vector.v[1], -vector.v[2], -vector.v[3] };
    return v;
#endif
}

inline UTKVector4 UTKVector4Add(UTKVector4 vectorLeft, UTKVector4 vectorRight)
{
#if defined(__ARM_NEON__)
    float32x4_t v = vaddq_f32(*(float32x4_t *)&vectorLeft,
                              *(float32x4_t *)&vectorRight);
    return *(UTKVector4 *)&v;
#else
    UTKVector4 v = { vectorLeft.v[0] + vectorRight.v[0],
                     vectorLeft.v[1] + vectorRight.v[1],
                     vectorLeft.v[2] + vectorRight.v[2],
                     vectorLeft.v[3] + vectorRight.v[3] };
    return v;
#endif
}

inline UTKVector4 UTKVector4Subtract(UTKVector4 vectorLeft, UTKVector4 vectorRight)
{
#if defined(__ARM_NEON__)
    float32x4_t v = vsubq_f32(*(float32x4_t *)&vectorLeft,
                              *(float32x4_t *)&vectorRight);
    return *(UTKVector4 *)&v;
#else
    UTKVector4 v = { vectorLeft.v[0] - vectorRight.v[0],
                     vectorLeft.v[1] - vectorRight.v[1],
                     vectorLeft.v[2] - vectorRight.v[2],
                     vectorLeft.v[3] - vectorRight.v[3] };
    return v;
#endif
}

inline UTKVector4 UTKVector4Multiply(UTKVector4 vectorLeft, UTKVector4 vectorRight)
{
#if defined(__ARM_NEON__)
    float32x4_t v = vmulq_f32(*(float32x4_t *)&vectorLeft,
                              *(float32x4_t *)&vectorRight);
    return *(UTKVector4 *)&v;
#else
    UTKVector4 v = { vectorLeft.v[0] * vectorRight.v[0],
                     vectorLeft.v[1] * vectorRight.v[1],
                     vectorLeft.v[2] * vectorRight.v[2],
                     vectorLeft.v[3] * vectorRight.v[3] };
    return v;
#endif
}

inline UTKVector4 UTKVector4Divide(UTKVector4 vectorLeft, UTKVector4 vectorRight)
{
#if defined(__ARM_NEON__)
    float32x4_t *vLeft = (float32x4_t *)&vectorLeft;
    float32x4_t *vRight = (float32x4_t *)&vectorRight;
    float32x4_t estimate = vrecpeq_f32(*vRight);
    estimate = vmulq_f32(vrecpsq_f32(*vRight, estimate), estimate);
    estimate = vmulq_f32(vrecpsq_f32(*vRight, estimate), estimate);
    float32x4_t v = vmulq_f32(*vLeft, estimate);
    return *(UTKVector4 *)&v;
#else
    UTKVector4 v = { vectorLeft.v[0] / vectorRight.v[0],
                     vectorLeft.v[1] / vectorRight.v[1],
                     vectorLeft.v[2] / vectorRight.v[2],
                     vectorLeft.v[3] / vectorRight.v[3] };
    return v;
#endif
}

inline UTKVector4 UTKVector4AddScalar(UTKVector4 vector, float value)
{
#if defined(__ARM_NEON__)
    float32x4_t v = vaddq_f32(*(float32x4_t *)&vector,
                              vdupq_n_f32((float32_t)value));
    return *(UTKVector4 *)&v;
#else
    UTKVector4 v = { vector.v[0] + value,
                     vector.v[1] + value,
                     vector.v[2] + value,
                     vector.v[3] + value };
    return v;
#endif
}

inline UTKVector4 UTKVector4SubtractScalar(UTKVector4 vector, float value)
{
#if defined(__ARM_NEON__)
    float32x4_t v = vsubq_f32(*(float32x4_t *)&vector,
                              vdupq_n_f32((float32_t)value));
    return *(UTKVector4 *)&v;
#else
    UTKVector4 v = { vector.v[0] - value,
                     vector.v[1] - value,
                     vector.v[2] - value,
                     vector.v[3] - value };
    return v;
#endif
}

inline UTKVector4 UTKVector4MultiplyScalar(UTKVector4 vector, float value)
{
#if defined(__ARM_NEON__)
    float32x4_t v = vmulq_f32(*(float32x4_t *)&vector,
                              vdupq_n_f32((float32_t)value));
    return *(UTKVector4 *)&v;
#else
    UTKVector4 v = { vector.v[0] * value,
                     vector.v[1] * value,
                     vector.v[2] * value,
                     vector.v[3] * value };
    return v;
#endif
}

inline UTKVector4 UTKVector4DivideScalar(UTKVector4 vector, float value)
{
#if defined(__ARM_NEON__)
    float32x4_t values = vdupq_n_f32((float32_t)value);
    float32x4_t estimate = vrecpeq_f32(values);
    estimate = vmulq_f32(vrecpsq_f32(values, estimate), estimate);
    estimate = vmulq_f32(vrecpsq_f32(values, estimate), estimate);
    float32x4_t v = vmulq_f32(*(float32x4_t *)&vector, estimate);
    return *(UTKVector4 *)&v;
#else
    UTKVector4 v = { vector.v[0] / value,
                     vector.v[1] / value,
                     vector.v[2] / value,
                     vector.v[3] / value };
    return v;
#endif
}

inline UTKVector4 UTKVector4Normalize(UTKVector4 vector)
{
    float scale = 1.0f / UTKVector4Length(vector);
    UTKVector4 v = UTKVector4MultiplyScalar(vector, scale);
    return v;
}

inline float UTKVector4DotProduct(UTKVector4 vectorLeft, UTKVector4 vectorRight)
{
#if defined(__ARM_NEON__)
    float32x4_t v = vmulq_f32(*(float32x4_t *)&vectorLeft,
                              *(float32x4_t *)&vectorRight);
    float32x2_t v2 = vpadd_f32(vget_low_f32(v), vget_high_f32(v));
    v2 = vpadd_f32(v2, v2);
    return vget_lane_f32(v2, 0);
#else
    return vectorLeft.v[0] * vectorRight.v[0] +
           vectorLeft.v[1] * vectorRight.v[1] +
           vectorLeft.v[2] * vectorRight.v[2] +
           vectorLeft.v[3] * vectorRight.v[3];
#endif
}

inline float UTKVector4Length(UTKVector4 vector)
{
#if defined(__ARM_NEON__)
    float32x4_t v = vmulq_f32(*(float32x4_t *)&vector,
                              *(float32x4_t *)&vector);
    float32x2_t v2 = vpadd_f32(vget_low_f32(v), vget_high_f32(v));
    v2 = vpadd_f32(v2, v2);
    return sqrt(vget_lane_f32(v2, 0));
#else
    return sqrt(vector.v[0] * vector.v[0] +
                vector.v[1] * vector.v[1] +
                vector.v[2] * vector.v[2] +
                vector.v[3] * vector.v[3]);
#endif
}

inline float UTKVector4Distance(UTKVector4 vectorStart, UTKVector4 vectorEnd)
{
    return UTKVector4Length(UTKVector4Subtract(vectorEnd, vectorStart));
}

inline UTKVector4 UTKVector4Lerp(UTKVector4 vectorStart, UTKVector4 vectorEnd, float t)
{
#if defined(__ARM_NEON__)
    float32x4_t vDiff = vsubq_f32(*(float32x4_t *)&vectorEnd,
                                  *(float32x4_t *)&vectorStart);
    vDiff = vmulq_f32(vDiff, vdupq_n_f32((float32_t)t));
    float32x4_t v = vaddq_f32(*(float32x4_t *)&vectorStart, vDiff);
    return *(UTKVector4 *)&v;
#else
    UTKVector4 v = { vectorStart.v[0] + ((vectorEnd.v[0] - vectorStart.v[0]) * t),
                     vectorStart.v[1] + ((vectorEnd.v[1] - vectorStart.v[1]) * t),
                     vectorStart.v[2] + ((vectorEnd.v[2] - vectorStart.v[2]) * t),
                     vectorStart.v[3] + ((vectorEnd.v[3] - vectorStart.v[3]) * t) };
    return v;
#endif
}



#ifdef __cplusplus
}
#endif

')

@:cppFileCode('

#include <string>
#include <sstream>
#include <stdio.h>
')

@:headerClassCode('
public:
	UTKVector4 *_vectorData;
private:
	UTKVector4 _memVectorData;
')
class Vector4
{
    public var data(default, null) : Data;
    public var dataOffset(default, null) : Int;

    public function new(_data : Data = null, _dataOffset : Int = 0) : Void
    {
        data = new Data(0);
        dataOffset = _dataOffset;

        if(_data == null)
        {
            initDataWithVectorPointer();
        }
        else
        {
            initDataWithExistingVectorPointer(_data, dataOffset);
        }
    }

    @:functionCode('
        _vectorData = &_memVectorData;
		data->_nativeData->setupWithExistingPointer((uint8_t*)&_memVectorData, sizeof(_memVectorData));
	')
    public function initDataWithVectorPointer() : Void {}

    @:functionCode('
		data->_nativeData->setupWithExistingPointer((uint8_t*)otherData->_nativeData->ptr, otherData->_nativeData->allocedLength);
		_vectorData = (UTKVector4*)(otherData->_nativeData->ptr + dataOffset);
	')
    public function initDataWithExistingVectorPointer(otherData:Data, dataOffset:Int) : Void {}


/// Vector Interface

    public var x(get, set) : Float;
    public var y(get, set) : Float;
    public var z(get, set) : Float;
    public var w(get, set) : Float;


    @:functionCode('
		return _vectorData->v[0];
	')
    public function get_x() : Float { return 0; }

    @:functionCode('
		_vectorData->v[0] = _x;
		return _x;
	')
    public function set_x(_x : Float) : Float { return _x; }



    @:functionCode('
		return _vectorData->v[1];
	')
    public function get_y() : Float { return 0; }

    @:functionCode('
		_vectorData->v[1] = _y;
		return _y;
	')
    public function set_y(_y : Float) : Float { return _y; }



    @:functionCode('
		return _vectorData->v[2];
	')
    public function get_z() : Float { return 0; }

    @:functionCode('
		_vectorData->v[2] = _z;
		return _z;
	')
    public function set_z(_z : Float) : Float { return _z; }



    @:functionCode('
		return _vectorData->v[3];
	')
    public function get_w() : Float { return 0; }

    @:functionCode('
		_vectorData->v[3] = _w;
		return _w;
	')
    public function set_w(_w : Float) : Float { return _w; }



/// Color Interface

    public var r(get, set) : Float;
    public var g(get, set) : Float;
    public var b(get, set) : Float;
    public var a(get, set) : Float;

    @:functionCode('
		return _vectorData->v[0];
	')
    public function get_r() : Float { return 0; }

    @:functionCode('
		_vectorData->v[0] = _r;
		return _r;
	')
    public function set_r(_r : Float) : Float { return _r; }



    @:functionCode('
		return _vectorData->v[1];
	')
    public function get_g() : Float { return 0; }

    @:functionCode('
		_vectorData->v[1] = _g;
		return _g;
	')
    public function set_g(_g : Float) : Float { return _g; }



    @:functionCode('
		return _vectorData->v[2];
	')
    public function get_b() : Float { return 0; }

    @:functionCode('
		_vectorData->v[2] = _b;
		return _b;
	')
    public function set_b(_b : Float) : Float { return _b; }



    @:functionCode('
		return _vectorData->v[3];
	')
    public function get_a() : Float { return 0; }

    @:functionCode('
		_vectorData->v[3] = _a;
		return _a;
	')
    public function set_a(_a : Float) : Float { return _a; }


/// Setters & Getters

    @:functionCode('
		_vectorData->v[0] = _x;
		_vectorData->v[1] = _y;
		_vectorData->v[2] = _z;
		_vectorData->v[3] = _w;
	')
    public function setXYZW(_x : Float, _y : Float, _z : Float, _w : Float) : Void { }


    @:functionCode('
		_vectorData->v[0] = _r;
		_vectorData->v[1] = _g;
		_vectorData->v[2] = _b;
		_vectorData->v[3] = _a;
	')
    public function setRGBA(_r : Float, _g : Float, _b : Float, _a : Float) : Void { }


    @:functionCode('
		*_vectorData = *other->_vectorData;
	')
    public function set(other : Vector4) : Void { }


    @:functionCode('
		return _vectorData->v[index];
	')
    public function get(index : Int) : Float { return 0; }


/// Math

    @:functionCode('
		*_vectorData = UTKVector4Negate(*_vectorData);
	')
    public function negate() : Void { }


    @:functionCode('
        *_vectorData = UTKVector4Add(*_vectorData, *right->_vectorData);
    ')
    public function add(right : Vector4) : Void { }


    @:functionCode('
        *_vectorData = UTKVector4Subtract(*_vectorData, *right->_vectorData);
    ')
    public function subtract(right : Vector4) : Void { }


    @:functionCode('
        *_vectorData = UTKVector4Multiply(*_vectorData, *right->_vectorData);
    ')
    public function multiply(right : Vector4) : Void { }


    @:functionCode('
        *_vectorData = UTKVector4Divide(*_vectorData, *right->_vectorData);
    ')
    public function divide(right : Vector4) : Void { }


    @:functionCode('
        *_vectorData = UTKVector4AddScalar(*_vectorData, value);
    ')
    public function addScalar(value : Float) : Void { }


    @:functionCode('
        *_vectorData = UTKVector4SubtractScalar(*_vectorData, value);
    ')
    public function subtractScalar(value : Float) : Void { }


    @:functionCode('
        *_vectorData = UTKVector4MultiplyScalar(*_vectorData, value);
    ')
    public function multiplyScalar(value : Float) : Void { }


    @:functionCode('
        *_vectorData = UTKVector4DivideScalar(*_vectorData, value);
    ')
    public function divideScalar(value : Float) : Void { }


    @:functionCode('
        *_vectorData = UTKVector4Normalize(*_vectorData);
    ')
    public function normalize() : Void { }


    @:functionCode('
        *_vectorData = UTKVector4Lerp(*start->_vectorData, *end->_vectorData, t);
    ')
    public function lerp(start : Vector4, end : Vector4, t : Float) : Void { }


    @:functionCode('
        return UTKVector4Length(*vector->_vectorData);
    ')
    public static function length(vector : Vector4) : Float { return 0; }


    @:functionCode('
        return UTKVector4DotProduct(*vector->_vectorData, *vector->_vectorData);
    ')
    public static function lengthSquared(vector : Vector4) : Float { return 0; }


    @:functionCode('
        return UTKVector4Distance(*start->_vectorData, *end->_vectorData);
    ')
    public static function distance(start : Vector4, end : Vector4) : Float { return 0; }


    @:functionCode('
		std::wostringstream oss;

		oss << "[";

        oss << _vectorData->v[0] + 0.0f; ///hack to not print -0
        oss << ", ";
        oss << _vectorData->v[1] + 0.0f; ///hack to not print -0
        oss << ", ";
        oss << _vectorData->v[2] + 0.0f; ///hack to not print -0
        oss << ", ";
        oss << _vectorData->v[3] + 0.0f; ///hack to not print -0

        oss << "]";

		std::wstring str = oss.str();

		return ::String(str.c_str(), str.size() + 1);
	')
    public function toString() : String { return ""; }

}