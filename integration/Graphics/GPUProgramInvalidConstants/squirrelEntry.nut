//A test to check that values can be changed from within gpu programs.

function start(){

    //Setup the compositor so we can see things.
    local renderTexture = _window.getRenderTexture();
    ::workspace <- _compositor.addWorkspace([renderTexture], _camera.getCamera(), "testWorkspace", true);

    local material = _graphics.getMaterialByName("Postprocess/glitchEffect");
    local prog = material.getFragmentProgramParameters(0, 0);

    local functions = [
        //Set invalid for int.
        function(){ prog.setNamedConstant("stage", 30.0); },
        function(){ prog.setNamedConstant("stage", false); },
        function(){ prog.setNamedConstant("stage", "invalid"); },
        function(){ prog.setNamedConstant("stage", Vec2(0, 0)); },
        function(){ prog.setNamedConstant("stage", Vec3(0, 0, 1)); },
        function(){ prog.setNamedConstant("stage", ColourValue(0, 0, 1, 1)); },

        //Set invalid for float.
        function(){ prog.setNamedConstant("firstVal", 30); },
        function(){ prog.setNamedConstant("firstVal", false); },
        function(){ prog.setNamedConstant("firstVal", "invalid"); },
        function(){ prog.setNamedConstant("firstVal", Vec2(0, 0)); },
        function(){ prog.setNamedConstant("firstVal", Vec3(0, 0, 1)); },
        function(){ prog.setNamedConstant("firstVal", ColourValue(0, 0, 1, 1)); },

        //Set invalid for vec3.
        function(){ prog.setNamedConstant("secondVal", 30); },
        function(){ prog.setNamedConstant("secondVal", false); },
        function(){ prog.setNamedConstant("secondVal", "invalid"); },
        function(){ prog.setNamedConstant("secondVal", Vec2(0, 0)); },
        function(){ prog.setNamedConstant("secondVal", ColourValue(0, 0, 1, 1)); },

        //Set invalid for vec2.
        function(){ prog.setNamedConstant("secondVal", 30); },
        function(){ prog.setNamedConstant("secondVal", false); },
        function(){ prog.setNamedConstant("secondVal", "invalid"); },
        function(){ prog.setNamedConstant("secondVal", ColourValue(0, 0, 1, 1)); },

        //Set invalid for vec4.
        function(){ prog.setNamedConstant("colourVal", 30); },
        function(){ prog.setNamedConstant("colourVal", false); },
        function(){ prog.setNamedConstant("colourVal", "invalid"); },

        //Set invalid for unsigned int.
        function(){ prog.setNamedConstant("unsignedInteger", 40.0); },
        function(){ prog.setNamedConstant("unsignedInteger", false); },
        function(){ prog.setNamedConstant("unsignedInteger", "invalid"); },
        function(){ prog.setNamedConstant("unsignedInteger", Vec2(0, 0)); },
        function(){ prog.setNamedConstant("unsignedInteger", Vec3(0, 0, 1)); },
        function(){ prog.setNamedConstant("unsignedInteger", ColourValue(0, 0, 1, 1)); },

        //Set invalid for boolean.
        function(){ prog.setNamedConstant("boolValue", 40.0); },
        function(){ prog.setNamedConstant("boolValue", "invalid"); },
        function(){ prog.setNamedConstant("boolValue", Vec2(0, 0)); },
        function(){ prog.setNamedConstant("boolValue", Vec3(0, 0, 1)); },
        function(){ prog.setNamedConstant("boolValue", ColourValue(0, 0, 1, 1)); },
    ];
    for(local i = 0; i < functions.len(); i++){
        local failed = false;
        try{
            functions[i]();
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);

        print(format("Finished calling function %i", i));
    }

    //Set valid values.
    prog.setNamedConstant("boolValue", true);
    prog.setNamedConstant("boolValue", false);
    prog.setNamedConstant("stage", 2);
    prog.setNamedConstant("firstVal", 20.0);

    _test.endTest();

}