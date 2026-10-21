uniform float time_0_X;
uniform float sin_time_0_X;

uniform int stage;
uniform float firstVal;
uniform float3 secondVal;
uniform float2 thirdVal;
uniform float4 colourVal;

uniform float array[4];
uniform uint unsignedInteger;
//Ogre's D3D11 reflection has no constant type for an HLSL bool, so it's declared as a uint, which is what glslang reflects the GLSL bool as on Vulkan.
uniform uint boolValue;

uniform float arrayLenFourFloat[4];
uniform int arrayLenFourInt[4];
uniform uint arrayLenFourIntUnsigned[4];
uniform float4 arrayLenFourFloat4[4];

float4 main( float2 uv : TEXCOORD0 ) : SV_Target
{
    if(stage == 0 || stage == 12){
        return float4(firstVal, firstVal, firstVal, 1.0);
    }
    else if(stage == 1){
        return float4(secondVal, 1.0);
    }
    else if(stage == 2){
        return float4(thirdVal.x, thirdVal.y, 0.0, 1.0);
    }
    else if(stage == 3){
        return colourVal;
    }
    else if(stage == 4){
        return float4(array[0], array[1], array[2], array[3]);
    }
    else if(stage == 5){
        return boolValue != 0 ? float4(1.0, 1.0, 1.0, 1.0) : float4(0.0, 0.0, 0.0, 1.0);
    }
    else if(stage == 6 || stage == 7 || stage == 8){
        return float4(arrayLenFourFloat[0], arrayLenFourFloat[1], arrayLenFourFloat[2], arrayLenFourFloat[3]);
    }
    else if(stage == 9){
        return float4((float)arrayLenFourInt[0] / 4.0, (float)arrayLenFourInt[1] / 4.0, (float)arrayLenFourInt[2] / 4.0, (float)arrayLenFourInt[3] / 4.0);
    }
    else if(stage == 10){
        return float4((float)arrayLenFourIntUnsigned[0] / 4.0, (float)arrayLenFourIntUnsigned[1] / 4.0, (float)arrayLenFourIntUnsigned[2] / 4.0, (float)arrayLenFourIntUnsigned[3] / 4.0);
    }
    else if(stage == 11){
        return arrayLenFourFloat4[0];
    }
    else if(stage < 0){
        //Not reached by the tests. Ogre's D3D11 backend only reflects the constants a shader reads, so this reads the ones nothing else does.
        return float4(time_0_X, sin_time_0_X, (float)unsignedInteger, 1.0)
            + arrayLenFourFloat4[1] + arrayLenFourFloat4[2] + arrayLenFourFloat4[3];
    }

    return float4(0.0, 0.0, 0.0, 0.0);
}
