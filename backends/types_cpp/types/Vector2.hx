/*
 * Copyright (c) 2003-2015, GameDuell GmbH
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package types;

import types.Data;

@:headerCode('
#include <hxMath.h>

#include <types/NativeData.h>


#ifdef __cplusplus
extern "C" {
#endif


union _UTKVector2
{
    struct
    {
        float x, y;
    };
    float v[2];
};
typedef union _UTKVector2 UTKVector2;



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



inline UTKVector2 UTKVector2Negate(UTKVector2 vector);

inline UTKVector2 UTKVector2Add(UTKVector2 vectorLeft, UTKVector2 vectorRight);
inline UTKVector2 UTKVector2Subtract(UTKVector2 vectorLeft, UTKVector2 vectorRight);
inline UTKVector2 UTKVector2Multiply(UTKVector2 vectorLeft, UTKVector2 vectorRight);
inline UTKVector2 UTKVector2Divide(UTKVector2 vectorLeft, UTKVector2 vectorRight);

inline UTKVector2 UTKVector2AddScalar(UTKVector2 vector, float value);
inline UTKVector2 UTKVector2SubtractScalar(UTKVector2 vector, float value);
inline UTKVector2 UTKVector2MultiplyScalar(UTKVector2 vector, float value);
inline UTKVector2 UTKVector2DivideScalar(UTKVector2 vector, float value);

inline UTKVector2 UTKVector2Normalize(UTKVector2 vector);

inline float UTKVector2DotProduct(UTKVector2 vectorLeft, UTKVector2 vectorRight);
inline float UTKVector2Length(UTKVector2 vector);
inline float UTKVector2Distance(UTKVector2 vectorStart, UTKVector2 vectorEnd);

inline UTKVector2 UTKVector2Lerp(UTKVector2 vectorStart, UTKVector2 vectorEnd, float t);




inline UTKVector2 UTKVector2Negate(UTKVector2 vector)
{
#if defined(__ARM_NEON__)
    float32x2_t v = vneg_f32(*(float32x2_t *)&vector);
    return *(UTKVector2 *)&v;
#else
    UTKVector2 v = { -vector.v[0] , -vector.v[1] };
    return v;
#endif
}

inline UTKVector2 UTKVector2Add(UTKVector2 vectorLeft, UTKVector2 vectorRight)
{
#if defined(__ARM_NEON__)
    float32x2_t v = vadd_f32(*(float32x2_t *)&vectorLeft,
                             *(float32x2_t *)&vectorRight);
    return *(UTKVector2 *)&v;
#else
    UTKVector2 v = { vectorLeft.v[0] + vectorRight.v[0],
                     vectorLeft.v[1] + vectorRight.v[1] };
    return v;
#endif
}

inline UTKVector2 UTKVector2Subtract(UTKVector2 vectorLeft, UTKVector2 vectorRight)
{
#if defined(__ARM_NEON__)
    float32x2_t v = vsub_f32(*(float32x2_t *)&vectorLeft,
                             *(float32x2_t *)&vectorRight);
    return *(UTKVector2 *)&v;
#else
    UTKVector2 v = { vectorLeft.v[0] - vectorRight.v[0],
                     vectorLeft.v[1] - vectorRight.v[1] };
    return v;
#endif
}

inline UTKVector2 UTKVector2Multiply(UTKVector2 vectorLeft, UTKVector2 vectorRight)
{
#if defined(__ARM_NEON__)
    float32x2_t v = vmul_f32(*(float32x2_t *)&vectorLeft,
                             *(float32x2_t *)&vectorRight);
    return *(UTKVector2 *)&v;
#else
    UTKVector2 v = { vectorLeft.v[0] * vectorRight.v[0],
                     vectorLeft.v[1] * vectorRight.v[1] };
    return v;
#endif
}

inline UTKVector2 UTKVector2Divide(UTKVector2 vectorLeft, UTKVector2 vectorRight)
{
#if defined(__ARM_NEON__)
    float32x2_t *vLeft = (float32x2_t *)&vectorLeft;
    float32x2_t *vRight = (float32x2_t *)&vectorRight;
    float32x2_t estimate = vrecpe_f32(*vRight);
    estimate = vmul_f32(vrecps_f32(*vRight, estimate), estimate);
    estimate = vmul_f32(vrecps_f32(*vRight, estimate), estimate);
    float32x2_t v = vmul_f32(*vLeft, estimate);
    return *(UTKVector2 *)&v;
#else
    UTKVector2 v = { vectorLeft.v[0] / vectorRight.v[0],
                     vectorLeft.v[1] / vectorRight.v[1] };
    return v;
#endif
}

inline UTKVector2 UTKVector2AddScalar(UTKVector2 vector, float value)
{
#if defined(__ARM_NEON__)
    float32x2_t v = vadd_f32(*(float32x2_t *)&vector,
                             vdup_n_f32((float32_t)value));
    return *(UTKVector2 *)&v;
#else
    UTKVector2 v = { vector.v[0] + value,
                     vector.v[1] + value };
    return v;
#endif
}

inline UTKVector2 UTKVector2SubtractScalar(UTKVector2 vector, float value)
{
#if defined(__ARM_NEON__)
    float32x2_t v = vsub_f32(*(float32x2_t *)&vector,
                             vdup_n_f32((float32_t)value));
    return *(UTKVector2 *)&v;
#else
    UTKVector2 v = { vector.v[0] - value,
                     vector.v[1] - value };
    return v;
#endif
}

inline UTKVector2 UTKVector2MultiplyScalar(UTKVector2 vector, float value)
{
#if defined(__ARM_NEON__)
    float32x2_t v = vmul_f32(*(float32x2_t *)&vector,
                             vdup_n_f32((float32_t)value));
    return *(UTKVector2 *)&v;
#else
    UTKVector2 v = { vector.v[0] * value,
                     vector.v[1] * value };
    return v;
#endif
}

inline UTKVector2 UTKVector2DivideScalar(UTKVector2 vector, float value)
{
#if defined(__ARM_NEON__)
    float32x2_t values = vdup_n_f32((float32_t)value);
    float32x2_t estimate = vrecpe_f32(values);
    estimate = vmul_f32(vrecps_f32(values, estimate), estimate);
    estimate = vmul_f32(vrecps_f32(values, estimate), estimate);
    float32x2_t v = vmul_f32(*(float32x2_t *)&vector, estimate);
    return *(UTKVector2 *)&v;
#else
    UTKVector2 v = { vector.v[0] / value,
                     vector.v[1] / value };
    return v;
#endif
}

inline UTKVector2 UTKVector2Normalize(UTKVector2 vector)
{
    float scale = 1.0f / UTKVector2Length(vector);
    UTKVector2 v = UTKVector2MultiplyScalar(vector, scale);
    return v;
}

inline float UTKVector2DotProduct(UTKVector2 vectorLeft, UTKVector2 vectorRight)
{
#if defined(__ARM_NEON__)
    float32x2_t v = vmul_f32(*(float32x2_t *)&vectorLeft,
                             *(float32x2_t *)&vectorRight);
    v = vpadd_f32(v, v);
    return vget_lane_f32(v, 0);
#else
    return vectorLeft.v[0] * vectorRight.v[0] + vectorLeft.v[1] * vectorRight.v[1];
#endif
}

inline float UTKVector2Length(UTKVector2 vector)
{
#if defined(__ARM_NEON__)
    float32x2_t v = vmul_f32(*(float32x2_t *)&vector,
                             *(float32x2_t *)&vector);
    v = vpadd_f32(v, v);
    return sqrt(vget_lane_f32(v, 0));
#else
    return sqrt(vector.v[0] * vector.v[0] + vector.v[1] * vector.v[1]);
#endif
}

inline float UTKVector2Distance(UTKVector2 vectorStart, UTKVector2 vectorEnd)
{
    return UTKVector2Length(UTKVector2Subtract(vectorEnd, vectorStart));
}

inline UTKVector2 UTKVector2Lerp(UTKVector2 vectorStart, UTKVector2 vectorEnd, float t)
{
#if defined(__ARM_NEON__)
    float32x2_t vDiff = vsub_f32(*(float32x2_t *)&vectorEnd,
                                 *(float32x2_t *)&vectorStart);
    vDiff = vmul_f32(vDiff, vdup_n_f32((float32_t)t));
    float32x2_t v = vadd_f32(*(float32x2_t *)&vectorStart, vDiff);
    return *(UTKVector2 *)&v;
#else
    UTKVector2 v = { vectorStart.v[0] + ((vectorEnd.v[0] - vectorStart.v[0]) * t),
                     vectorStart.v[1] + ((vectorEnd.v[1] - vectorStart.v[1]) * t) };
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
	UTKVector2 *_vectorData;
private:
	UTKVector2 _memVectorData;
')
class Vector2
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
		_vectorData = (UTKVector2*)(otherData->_nativeData->ptr + dataOffset);
	')
    public function initDataWithExistingVectorPointer(otherData:Data, dataOffset:Int) : Void {}


/// Vector Interface

    public var x(get, set) : Float;
    public var y(get, set) : Float;


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


/// Texture Coordinate Interface

    public var s(get, set) : Float;
    public var t(get, set) : Float;

    @:functionCode('
		return _vectorData->v[0];
	')
    public function get_s() : Float { return 0; }

    @:functionCode('
		_vectorData->v[0] = _s;
		return _s;
	')
    public function set_s(_s : Float) : Float { return _s; }



    @:functionCode('
		return _vectorData->v[1];
	')
    public function get_t() : Float { return 0; }

    @:functionCode('
		_vectorData->v[1] = _t;
		return _t;
	')
    public function set_t(_t : Float) : Float { return _t; }

/// Setters & Getters

    @:functionCode('
		_vectorData->v[0] = _x;
		_vectorData->v[1] = _y;
	')
    public function setXY(_x : Float, _y : Float) : Void { }


    @:functionCode('
		_vectorData->v[0] = _s;
		_vectorData->v[1] = _t;
	')
    public function setST(_s : Float, _t : Float) : Void { }


    @:functionCode('
		*_vectorData = *other->_vectorData;
	')
    public function set(other : Vector2) : Void { }


    @:functionCode('
		return _vectorData->v[index];
	')
    public function get(index : Int) : Float { return 0; }


/// Math

    @:functionCode('
		*_vectorData = UTKVector2Negate(*_vectorData);
	')
    public function negate() : Void { }


    @:functionCode('
        *_vectorData = UTKVector2Add(*_vectorData, *right->_vectorData);
    ')
    public function add(right : Vector2) : Void { }


    @:functionCode('
        *_vectorData = UTKVector2Subtract(*_vectorData, *right->_vectorData);
    ')
    public function subtract(right : Vector2) : Void { }


    @:functionCode('
        *_vectorData = UTKVector2Multiply(*_vectorData, *right->_vectorData);
    ')
    public function multiply(right : Vector2) : Void { }


    @:functionCode('
        *_vectorData = UTKVector2Divide(*_vectorData, *right->_vectorData);
    ')
    public function divide(right : Vector2) : Void { }


    @:functionCode('
        *_vectorData = UTKVector2AddScalar(*_vectorData, value);
    ')
    public function addScalar(value : Float) : Void { }


    @:functionCode('
        *_vectorData = UTKVector2SubtractScalar(*_vectorData, value);
    ')
    public function subtractScalar(value : Float) : Void { }


    @:functionCode('
        *_vectorData = UTKVector2MultiplyScalar(*_vectorData, value);
    ')
    public function multiplyScalar(value : Float) : Void { }


    @:functionCode('
        *_vectorData = UTKVector2DivideScalar(*_vectorData, value);
    ')
    public function divideScalar(value : Float) : Void { }


    @:functionCode('
        *_vectorData = UTKVector2Normalize(*_vectorData);
    ')
    public function normalize() : Void { }


    @:functionCode('
        *_vectorData = UTKVector2Lerp(*start->_vectorData, *end->_vectorData, t);
    ')
    public function lerp(start : Vector2, end : Vector2, t : Float) : Void { }


    @:functionCode('
        return UTKVector2Length(*vector->_vectorData);
    ')
    public static function length(vector : Vector2) : Float { return 0; }


    @:functionCode('
        return UTKVector2DotProduct(*vector->_vectorData, *vector->_vectorData);
    ')
    public static function lengthSquared(vector : Vector2) : Float { return 0; }


    @:functionCode('
        return UTKVector2Distance(*start->_vectorData, *end->_vectorData);
    ')
    public static function distance(start : Vector2, end : Vector2) : Float { return 0; }


    @:functionCode('
		std::wostringstream oss;

		oss << "[";

        oss << _vectorData->v[0] + 0.0f; ///hack to not print -0
        oss << ", ";
        oss << _vectorData->v[1] + 0.0f; ///hack to not print -0

        oss << "]";

		std::wstring str = oss.str();

		return ::String(str.c_str(), str.size() + 1);
	')
    public function toString() : String { return ""; }

}
