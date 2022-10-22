#version ogre_glsl_ver_330

vulkan_layout( location = 0 )
out vec4 fragColour;

vulkan_layout( location = 0 )
in block
{
    int stage;
    vec firstVal;
    vec4 secondVal;
    vec2 thirdVal;
    vec4 colourVal;
} inPs;

vulkan( layout( ogre_P0 ) uniform Params { )

vulkan( }; )

void main()
{
    if(inPs.stage == 0){
        return vec4(inPs.firstVal, inPs.firstVal, inPs.firstVal, 1.0);
    }
    else if(inPs.stage == 1){
        return inPs.secondVal;
    }
    else if(inPs.stage == 2){
        return vec4(inPs.thirdVal.x, inPs.thirdVal.y, 0, 1.0);
    }
    else if(inPs.stage == 3){
        return inPs.colourVal;
    }
}
