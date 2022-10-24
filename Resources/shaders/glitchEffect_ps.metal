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
};

fragment float4 main_metal
(
    constant Params &p [[buffer(PARAMETER_SLOT)]]
)
{
    if(p.stage == 0){
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
    else{
        return float4(0, 0, 0, 0);
    }

}
