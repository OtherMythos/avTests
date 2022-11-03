#include <metal_stdlib>
using namespace metal;

struct Params
{
    float time_0_X;
    float sin_time_0_X;

    int stage;
    float firstVal;
    float3 secondVal;
    float2 thirdVal;
    float4 colourVal;

    float array[4];
    unsigned int unsignedInteger;
    bool boolValue;

    float arrayLenFourFloat[4];
    int arrayLenFourInt[4];
    unsigned int arrayLenFourIntUnsigned[4];
    float4 arrayLenFourFloat4[4];
};

fragment float4 main_metal
(
    constant Params &p [[buffer(PARAMETER_SLOT)]]
)
{
    if(p.stage == 0 || p.stage == 12){
        return float4(p.firstVal, p.firstVal, p.firstVal, 1.0);
    }
    else if(p.stage == 1){
        return float4(p.secondVal, 1.0);
    }
    else if(p.stage == 2){
        return float4(p.thirdVal.x, p.thirdVal.y, 0, 1.0);
    }
    else if(p.stage == 3){
        return p.colourVal;
    }
    else if(p.stage == 4){
        return float4(p.array[0], p.array[1], p.array[2], p.array[3]);
    }
    else if(p.stage == 5){
        return p.boolValue ? float4(1.0, 1.0, 1.0, 1.0) : float4(0.0, 0.0, 0.0, 1.0);
    }
    else if(p.stage == 6 || p.stage == 7 || p.stage == 8){
        return float4(p.arrayLenFourFloat[0], p.arrayLenFourFloat[1], p.arrayLenFourFloat[2], p.arrayLenFourFloat[3]);
    }
    else if(p.stage == 9){
        return float4(p.arrayLenFourInt[0] / 4.0, p.arrayLenFourInt[1] / 4.0, p.arrayLenFourInt[2] / 4.0, p.arrayLenFourInt[3] / 4.0);
    }
    else if(p.stage == 10){
        return float4(p.arrayLenFourIntUnsigned[0] / 4.0, p.arrayLenFourIntUnsigned[1] / 4.0, p.arrayLenFourIntUnsigned[2] / 4.0, p.arrayLenFourIntUnsigned[3] / 4.0);
    }
    else if(p.stage == 11){
        return p.arrayLenFourFloat4[0];
    }
    else{
        return float4(0, 0, 0, 0);
    }

}
