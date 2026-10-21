#version ogre_glsl_ver_330

vulkan_layout( location = 0 )
out vec4 fragColour;

vulkan( layout( ogre_P0 ) uniform Params { )
    uniform float time_0_X;
    uniform float sin_time_0_X;

    uniform int stage;
    uniform float firstVal;
    uniform vec3 secondVal;
    uniform vec2 thirdVal;
    uniform vec4 colourVal;

    uniform float array[4];
    uniform uint unsignedInteger;
    uniform bool boolValue;

    uniform float arrayLenFourFloat[4];
    uniform int arrayLenFourInt[4];
    uniform uint arrayLenFourIntUnsigned[4];
    uniform vec4 arrayLenFourFloat4[4];
vulkan( }; )

void main()
{
    if(stage == 0 || stage == 12){
        fragColour = vec4(firstVal, firstVal, firstVal, 1.0);
    }
    else if(stage == 1){
        fragColour = vec4(secondVal, 1.0);
    }
    else if(stage == 2){
        fragColour = vec4(thirdVal.x, thirdVal.y, 0.0, 1.0);
    }
    else if(stage == 3){
        fragColour = colourVal;
    }
    else if(stage == 4){
        fragColour = vec4(array[0], array[1], array[2], array[3]);
    }
    else if(stage == 5){
        fragColour = boolValue ? vec4(1.0, 1.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
    }
    else if(stage == 6 || stage == 7 || stage == 8){
        fragColour = vec4(arrayLenFourFloat[0], arrayLenFourFloat[1], arrayLenFourFloat[2], arrayLenFourFloat[3]);
    }
    else if(stage == 9){
        fragColour = vec4(float(arrayLenFourInt[0]) / 4.0, float(arrayLenFourInt[1]) / 4.0, float(arrayLenFourInt[2]) / 4.0, float(arrayLenFourInt[3]) / 4.0);
    }
    else if(stage == 10){
        fragColour = vec4(float(arrayLenFourIntUnsigned[0]) / 4.0, float(arrayLenFourIntUnsigned[1]) / 4.0, float(arrayLenFourIntUnsigned[2]) / 4.0, float(arrayLenFourIntUnsigned[3]) / 4.0);
    }
    else if(stage == 11){
        fragColour = arrayLenFourFloat4[0];
    }
    else if(stage < 0){
        //Not reached by the tests, but uses these values so GL can't optimise them out.
        //GL also reports an array's size from the highest element read, so every element has to be used.
        fragColour = vec4(time_0_X, sin_time_0_X, float(unsignedInteger), 1.0)
            + arrayLenFourFloat4[1] + arrayLenFourFloat4[2] + arrayLenFourFloat4[3];
    }
    else{
        fragColour = vec4(0.0, 0.0, 0.0, 0.0);
    }
}
