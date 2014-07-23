package types;

import types.Data;


@:headerCode('	
#include <hxMath.h>	

#include <types/NativeData.h>


#ifdef __cplusplus
extern "C" {
#endif			


union _UTKMatrix4
{
    struct
    {
        float m00, m01, m02, m03;
        float m10, m11, m12, m13;
        float m20, m21, m22, m23;
        float m30, m31, m32, m33;
    };
    float m[16];
};
typedef union _UTKMatrix4 UTKMatrix4;


static UTKMatrix4 identityMatrix = {1, 0, 0, 0,
                	     	   		0, 1, 0, 0,
                	     			0, 0, 1, 0,
                	     			0, 0, 0, 1 };

inline UTKMatrix4 UTKMatrix4MakeOrtho(	float left, float right,
        		                       	float bottom, float top,
          			                    float nearZ, float farZ)
{	
    float ral = right + left;
    float rsl = right - left;
    float tab = top + bottom;
    float tsb = top - bottom;
    float fan = farZ + nearZ;
    float fsn = farZ - nearZ;

    UTKMatrix4 m = { 2.0f / rsl, 0.0f      , 0.0f       , -ral / rsl,
                     0.0f      , 2.0f / tsb, 0.0f       , -tab / tsb,
                     0.0f      , 0.0f      , -2.0f / fsn, -fan / fsn,
                     0.0f      , 0.0f      , 0.0f       , 1.0f };
    return m;
}

inline UTKMatrix4 UTKMatrix4Make2D(	float translateX, float translateY,
        		                    float scale, float rotation)
{	
    float theta = rotation * ::Math_obj::PI / 180.0;
    float c = ::Math_obj::cos(theta);
    float s = ::Math_obj::sin(theta);
    
    UTKMatrix4 m = { c * scale,	s * scale, 0.0f, translateX,
                    -s * scale,	c * scale, 0.0f, translateY,
                     0.0f     ,	0.0f     , 1.0f, 0.0f,
                     0.0f     , 0.0f     , 0.0f, 1.0f };
                     
    return m;
}


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

#if __ANDROID__

//#include <cpu-features.h>
//#include <arm_neon.h>

#endif


inline UTKMatrix4 UTKMatrix4Multiply(UTKMatrix4 matrixLeft, UTKMatrix4 matrixRight)
{

#if __APPLE__

#if defined(__ARM_NEON__)
    float32x4x4_t iMatrixLeft = *(float32x4x4_t *)&matrixLeft;
    float32x4x4_t iMatrixRight = *(float32x4x4_t *)&matrixRight;
    float32x4x4_t m;
    m.val[0] = vmulq_n_f32(iMatrixLeft.val[0], vgetq_lane_f32(iMatrixRight.val[0], 0));
    m.val[1] = vmulq_n_f32(iMatrixLeft.val[0], vgetq_lane_f32(iMatrixRight.val[1], 0));
    m.val[2] = vmulq_n_f32(iMatrixLeft.val[0], vgetq_lane_f32(iMatrixRight.val[2], 0));
    m.val[3] = vmulq_n_f32(iMatrixLeft.val[0], vgetq_lane_f32(iMatrixRight.val[3], 0));

    m.val[0] = vmlaq_n_f32(m.val[0], iMatrixLeft.val[1], vgetq_lane_f32(iMatrixRight.val[0], 1));
    m.val[1] = vmlaq_n_f32(m.val[1], iMatrixLeft.val[1], vgetq_lane_f32(iMatrixRight.val[1], 1));
    m.val[2] = vmlaq_n_f32(m.val[2], iMatrixLeft.val[1], vgetq_lane_f32(iMatrixRight.val[2], 1));
    m.val[3] = vmlaq_n_f32(m.val[3], iMatrixLeft.val[1], vgetq_lane_f32(iMatrixRight.val[3], 1));

    m.val[0] = vmlaq_n_f32(m.val[0], iMatrixLeft.val[2], vgetq_lane_f32(iMatrixRight.val[0], 2));
    m.val[1] = vmlaq_n_f32(m.val[1], iMatrixLeft.val[2], vgetq_lane_f32(iMatrixRight.val[1], 2));
    m.val[2] = vmlaq_n_f32(m.val[2], iMatrixLeft.val[2], vgetq_lane_f32(iMatrixRight.val[2], 2));
    m.val[3] = vmlaq_n_f32(m.val[3], iMatrixLeft.val[2], vgetq_lane_f32(iMatrixRight.val[3], 2));

    m.val[0] = vmlaq_n_f32(m.val[0], iMatrixLeft.val[3], vgetq_lane_f32(iMatrixRight.val[0], 3));
    m.val[1] = vmlaq_n_f32(m.val[1], iMatrixLeft.val[3], vgetq_lane_f32(iMatrixRight.val[1], 3));
    m.val[2] = vmlaq_n_f32(m.val[2], iMatrixLeft.val[3], vgetq_lane_f32(iMatrixRight.val[2], 3));
    m.val[3] = vmlaq_n_f32(m.val[3], iMatrixLeft.val[3], vgetq_lane_f32(iMatrixRight.val[3], 3));

    return *(UTKMatrix4 *)&m;
    /*
#elif defined(GLK_SSE3_INTRINSICS)
	const __m128 l0 = _mm_load_ps(&matrixLeft.m[0]);
	const __m128 l1 = _mm_load_ps(&matrixLeft.m[4]);
	const __m128 l2 = _mm_load_ps(&matrixLeft.m[8]);
	const __m128 l3 = _mm_load_ps(&matrixLeft.m[12]);

	const __m128 r0 = _mm_load_ps(&matrixRight.m[0]);
	const __m128 r1 = _mm_load_ps(&matrixRight.m[4]);
	const __m128 r2 = _mm_load_ps(&matrixRight.m[8]);
	const __m128 r3 = _mm_load_ps(&matrixRight.m[12]);
	
	const __m128 m0 = l0 * _mm_shuffle_ps(r0, r0, _MM_SHUFFLE(0, 0, 0, 0))
					+ l1 * _mm_shuffle_ps(r0, r0, _MM_SHUFFLE(1, 1, 1, 1))
					+ l2 * _mm_shuffle_ps(r0, r0, _MM_SHUFFLE(2, 2, 2, 2))
					+ l3 * _mm_shuffle_ps(r0, r0, _MM_SHUFFLE(3, 3, 3, 3));

	const __m128 m1 = l0 * _mm_shuffle_ps(r1, r1, _MM_SHUFFLE(0, 0, 0, 0))
					+ l1 * _mm_shuffle_ps(r1, r1, _MM_SHUFFLE(1, 1, 1, 1))
					+ l2 * _mm_shuffle_ps(r1, r1, _MM_SHUFFLE(2, 2, 2, 2))
					+ l3 * _mm_shuffle_ps(r1, r1, _MM_SHUFFLE(3, 3, 3, 3));

	const __m128 m2 = l0 * _mm_shuffle_ps(r2, r2, _MM_SHUFFLE(0, 0, 0, 0))
					+ l1 * _mm_shuffle_ps(r2, r2, _MM_SHUFFLE(1, 1, 1, 1))
					+ l2 * _mm_shuffle_ps(r2, r2, _MM_SHUFFLE(2, 2, 2, 2))
					+ l3 * _mm_shuffle_ps(r2, r2, _MM_SHUFFLE(3, 3, 3, 3));

	const __m128 m3 = l0 * _mm_shuffle_ps(r3, r3, _MM_SHUFFLE(0, 0, 0, 0))
					+ l1 * _mm_shuffle_ps(r3, r3, _MM_SHUFFLE(1, 1, 1, 1))
					+ l2 * _mm_shuffle_ps(r3, r3, _MM_SHUFFLE(2, 2, 2, 2))
					+ l3 * _mm_shuffle_ps(r3, r3, _MM_SHUFFLE(3, 3, 3, 3));
				
	_mm_store_ps(&matrixLeft.m[0], m0);
	_mm_store_ps(&matrixLeft.m[4], m1);
	_mm_store_ps(&matrixLeft.m[8], m2);
	_mm_store_ps(&matrixLeft.m[12], m3);
    return matrixLeft;
*/
#else
   UTKMatrix4 m;
    
    m.m[0]  = matrixLeft.m[0] * matrixRight.m[0]  + matrixLeft.m[4] * matrixRight.m[1]  + matrixLeft.m[8] * matrixRight.m[2]   + matrixLeft.m[12] * matrixRight.m[3];
	m.m[4]  = matrixLeft.m[0] * matrixRight.m[4]  + matrixLeft.m[4] * matrixRight.m[5]  + matrixLeft.m[8] * matrixRight.m[6]   + matrixLeft.m[12] * matrixRight.m[7];
	m.m[8]  = matrixLeft.m[0] * matrixRight.m[8]  + matrixLeft.m[4] * matrixRight.m[9]  + matrixLeft.m[8] * matrixRight.m[10]  + matrixLeft.m[12] * matrixRight.m[11];
	m.m[12] = matrixLeft.m[0] * matrixRight.m[12] + matrixLeft.m[4] * matrixRight.m[13] + matrixLeft.m[8] * matrixRight.m[14]  + matrixLeft.m[12] * matrixRight.m[15];
    
	m.m[1]  = matrixLeft.m[1] * matrixRight.m[0]  + matrixLeft.m[5] * matrixRight.m[1]  + matrixLeft.m[9] * matrixRight.m[2]   + matrixLeft.m[13] * matrixRight.m[3];
	m.m[5]  = matrixLeft.m[1] * matrixRight.m[4]  + matrixLeft.m[5] * matrixRight.m[5]  + matrixLeft.m[9] * matrixRight.m[6]   + matrixLeft.m[13] * matrixRight.m[7];
	m.m[9]  = matrixLeft.m[1] * matrixRight.m[8]  + matrixLeft.m[5] * matrixRight.m[9]  + matrixLeft.m[9] * matrixRight.m[10]  + matrixLeft.m[13] * matrixRight.m[11];
	m.m[13] = matrixLeft.m[1] * matrixRight.m[12] + matrixLeft.m[5] * matrixRight.m[13] + matrixLeft.m[9] * matrixRight.m[14]  + matrixLeft.m[13] * matrixRight.m[15];
    
	m.m[2]  = matrixLeft.m[2] * matrixRight.m[0]  + matrixLeft.m[6] * matrixRight.m[1]  + matrixLeft.m[10] * matrixRight.m[2]  + matrixLeft.m[14] * matrixRight.m[3];
	m.m[6]  = matrixLeft.m[2] * matrixRight.m[4]  + matrixLeft.m[6] * matrixRight.m[5]  + matrixLeft.m[10] * matrixRight.m[6]  + matrixLeft.m[14] * matrixRight.m[7];
	m.m[10] = matrixLeft.m[2] * matrixRight.m[8]  + matrixLeft.m[6] * matrixRight.m[9]  + matrixLeft.m[10] * matrixRight.m[10] + matrixLeft.m[14] * matrixRight.m[11];
	m.m[14] = matrixLeft.m[2] * matrixRight.m[12] + matrixLeft.m[6] * matrixRight.m[13] + matrixLeft.m[10] * matrixRight.m[14] + matrixLeft.m[14] * matrixRight.m[15];
    
	m.m[3]  = matrixLeft.m[3] * matrixRight.m[0]  + matrixLeft.m[7] * matrixRight.m[1]  + matrixLeft.m[11] * matrixRight.m[2]  + matrixLeft.m[15] * matrixRight.m[3];
	m.m[7]  = matrixLeft.m[3] * matrixRight.m[4]  + matrixLeft.m[7] * matrixRight.m[5]  + matrixLeft.m[11] * matrixRight.m[6]  + matrixLeft.m[15] * matrixRight.m[7];
	m.m[11] = matrixLeft.m[3] * matrixRight.m[8]  + matrixLeft.m[7] * matrixRight.m[9]  + matrixLeft.m[11] * matrixRight.m[10] + matrixLeft.m[15] * matrixRight.m[11];
	m.m[15] = matrixLeft.m[3] * matrixRight.m[12] + matrixLeft.m[7] * matrixRight.m[13] + matrixLeft.m[11] * matrixRight.m[14] + matrixLeft.m[15] * matrixRight.m[15];
    
    return m;

#endif

#endif

/// without neon for now.
#if __ANDROID__

	//if (android_getCpuFamily() == ANDROID_CPU_FAMILY_ARM &&
    //    (android_getCpuFeatures() & ANDROID_CPU_ARM_FEATURE_NEON) != 0)
    //{
    	/*
	    float32x4x4_t iMatrixLeft = *(float32x4x4_t *)&matrixLeft;
	    float32x4x4_t iMatrixRight = *(float32x4x4_t *)&matrixRight;
	    float32x4x4_t out;

	    out.val[0] = vmulq_n_f32(iMatrixLeft.val[0], vgetq_lane_f32(iMatrixRight.val[0], 0));
	    out.val[1] = vmulq_n_f32(iMatrixLeft.val[0], vgetq_lane_f32(iMatrixRight.val[1], 0));
	    out.val[2] = vmulq_n_f32(iMatrixLeft.val[0], vgetq_lane_f32(iMatrixRight.val[2], 0));
	    out.val[3] = vmulq_n_f32(iMatrixLeft.val[0], vgetq_lane_f32(iMatrixRight.val[3], 0));

	    out.val[0] = vmlaq_n_f32(out.val[0], iMatrixLeft.val[1], vgetq_lane_f32(iMatrixRight.val[0], 1));
	    out.val[1] = vmlaq_n_f32(out.val[1], iMatrixLeft.val[1], vgetq_lane_f32(iMatrixRight.val[1], 1));
	    out.val[2] = vmlaq_n_f32(out.val[2], iMatrixLeft.val[1], vgetq_lane_f32(iMatrixRight.val[2], 1));
	    out.val[3] = vmlaq_n_f32(out.val[3], iMatrixLeft.val[1], vgetq_lane_f32(iMatrixRight.val[3], 1));

	    out.val[0] = vmlaq_n_f32(out.val[0], iMatrixLeft.val[2], vgetq_lane_f32(iMatrixRight.val[0], 2));
	    out.val[1] = vmlaq_n_f32(out.val[1], iMatrixLeft.val[2], vgetq_lane_f32(iMatrixRight.val[1], 2));
	    out.val[2] = vmlaq_n_f32(out.val[2], iMatrixLeft.val[2], vgetq_lane_f32(iMatrixRight.val[2], 2));
	    out.val[3] = vmlaq_n_f32(out.val[3], iMatrixLeft.val[2], vgetq_lane_f32(iMatrixRight.val[3], 2));

	    out.val[0] = vmlaq_n_f32(out.val[0], iMatrixLeft.val[3], vgetq_lane_f32(iMatrixRight.val[0], 3));
	    out.val[1] = vmlaq_n_f32(out.val[1], iMatrixLeft.val[3], vgetq_lane_f32(iMatrixRight.val[1], 3));
	    out.val[2] = vmlaq_n_f32(out.val[2], iMatrixLeft.val[3], vgetq_lane_f32(iMatrixRight.val[2], 3));
	    out.val[3] = vmlaq_n_f32(out.val[3], iMatrixLeft.val[3], vgetq_lane_f32(iMatrixRight.val[3], 3));

	    return *(UTKMatrix4 *)&out;
	    */
    //}
    //else
    //{
    	
	    UTKMatrix4 m;
	    
	    m.m[0]  = matrixLeft.m[0] * matrixRight.m[0]  + matrixLeft.m[4] * matrixRight.m[1]  + matrixLeft.m[8] * matrixRight.m[2]   + matrixLeft.m[12] * matrixRight.m[3];
		m.m[4]  = matrixLeft.m[0] * matrixRight.m[4]  + matrixLeft.m[4] * matrixRight.m[5]  + matrixLeft.m[8] * matrixRight.m[6]   + matrixLeft.m[12] * matrixRight.m[7];
		m.m[8]  = matrixLeft.m[0] * matrixRight.m[8]  + matrixLeft.m[4] * matrixRight.m[9]  + matrixLeft.m[8] * matrixRight.m[10]  + matrixLeft.m[12] * matrixRight.m[11];
		m.m[12] = matrixLeft.m[0] * matrixRight.m[12] + matrixLeft.m[4] * matrixRight.m[13] + matrixLeft.m[8] * matrixRight.m[14]  + matrixLeft.m[12] * matrixRight.m[15];
	    
		m.m[1]  = matrixLeft.m[1] * matrixRight.m[0]  + matrixLeft.m[5] * matrixRight.m[1]  + matrixLeft.m[9] * matrixRight.m[2]   + matrixLeft.m[13] * matrixRight.m[3];
		m.m[5]  = matrixLeft.m[1] * matrixRight.m[4]  + matrixLeft.m[5] * matrixRight.m[5]  + matrixLeft.m[9] * matrixRight.m[6]   + matrixLeft.m[13] * matrixRight.m[7];
		m.m[9]  = matrixLeft.m[1] * matrixRight.m[8]  + matrixLeft.m[5] * matrixRight.m[9]  + matrixLeft.m[9] * matrixRight.m[10]  + matrixLeft.m[13] * matrixRight.m[11];
		m.m[13] = matrixLeft.m[1] * matrixRight.m[12] + matrixLeft.m[5] * matrixRight.m[13] + matrixLeft.m[9] * matrixRight.m[14]  + matrixLeft.m[13] * matrixRight.m[15];
	    
		m.m[2]  = matrixLeft.m[2] * matrixRight.m[0]  + matrixLeft.m[6] * matrixRight.m[1]  + matrixLeft.m[10] * matrixRight.m[2]  + matrixLeft.m[14] * matrixRight.m[3];
		m.m[6]  = matrixLeft.m[2] * matrixRight.m[4]  + matrixLeft.m[6] * matrixRight.m[5]  + matrixLeft.m[10] * matrixRight.m[6]  + matrixLeft.m[14] * matrixRight.m[7];
		m.m[10] = matrixLeft.m[2] * matrixRight.m[8]  + matrixLeft.m[6] * matrixRight.m[9]  + matrixLeft.m[10] * matrixRight.m[10] + matrixLeft.m[14] * matrixRight.m[11];
		m.m[14] = matrixLeft.m[2] * matrixRight.m[12] + matrixLeft.m[6] * matrixRight.m[13] + matrixLeft.m[10] * matrixRight.m[14] + matrixLeft.m[14] * matrixRight.m[15];
	    
		m.m[3]  = matrixLeft.m[3] * matrixRight.m[0]  + matrixLeft.m[7] * matrixRight.m[1]  + matrixLeft.m[11] * matrixRight.m[2]  + matrixLeft.m[15] * matrixRight.m[3];
		m.m[7]  = matrixLeft.m[3] * matrixRight.m[4]  + matrixLeft.m[7] * matrixRight.m[5]  + matrixLeft.m[11] * matrixRight.m[6]  + matrixLeft.m[15] * matrixRight.m[7];
		m.m[11] = matrixLeft.m[3] * matrixRight.m[8]  + matrixLeft.m[7] * matrixRight.m[9]  + matrixLeft.m[11] * matrixRight.m[10] + matrixLeft.m[15] * matrixRight.m[11];
		m.m[15] = matrixLeft.m[3] * matrixRight.m[12] + matrixLeft.m[7] * matrixRight.m[13] + matrixLeft.m[11] * matrixRight.m[14] + matrixLeft.m[15] * matrixRight.m[15];
	    
	    return m;
	//}
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
	UTKMatrix4 _matrixData;			
') 
class Matrix4
{
	public var data(default, null) : Data;

	public function new() : Void
	{
		data = new Data(0);
		initDataWithMatrixPointer();
	}

	@:functionCode('
		data->_nativeData->setupWithExistingPointer((uint8_t*)&_matrixData, sizeof(_matrixData));
	') 
	public function initDataWithMatrixPointer() : Void {}

	@:functionCode('
		_matrixData = identityMatrix;
	') 
	public function setIdentity() : Void {}

	@:functionCode('
		_matrixData = UTKMatrix4MakeOrtho(x0, x1, y0, y1, zNear, zFar);
	') 
	public function setOrtho(	x0 : Float, 
								x1 : Float, 
								y0 : Float, 
								y1 : Float, 
								zNear : Float, 
								zFar : Float) : Void { }

	@:functionCode('
		_matrixData = UTKMatrix4Make2D(posX, posY, scale, rotation);
	') 
	public function set2D(	posX : Float, 
							posY : Float, 
							scale : Float, 
							rotation : Float) : Void { }

	@:functionCode('
		_matrixData = matrix->_matrixData;
	') 
	public function set(matrix : Matrix4) : Void { }

	@:functionCode('
		return _matrixData.m[row * 4 + col];
	') 
	public function get(row : Int, col : Int) : Float { return 0; }

	@:functionCode('
		_matrixData = UTKMatrix4Multiply(_matrixData, right->_matrixData);
	') 
	public function multiply(right : Matrix4) : Void { }

	@:functionCode('
		std::wostringstream oss;

		oss << "[";

		for(int i = 0; i < 4; ++i)
		{
			oss << _matrixData.m[i * 4 + 0];
			for(int j = 1; j < 4; ++j)
			{
				oss << ", ";
				oss << _matrixData.m[i * 4 + j] + 0.0f; ///hack to not print -0
			}

			if(i < 3)
				oss << ", ";
		}

		oss << "]";

		std::wstring str = oss.str();
		
		return ::String(str.c_str(), str.size() + 1);
	') 
	public function toString() : String { return ""; }


}