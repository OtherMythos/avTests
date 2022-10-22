//A test to check that values can be changed from within gpu programs.

function start(){

    //Setup the compositor so we can see things.
    local renderTexture = _window.getRenderTexture();
    ::workspace <- _compositor.addWorkspace([renderTexture], _camera.getCamera(), "testWorkspace", true);

    local material = _graphics.getMaterialByName("Postprocess/glitchEffect");
    print(material.getName());
    local fragmentParams = material.getFragmentProgramParameters(0, 0);
    print(fragmentParams);

    ::prog <- fragmentParams;

    ::testVal <- 0.0;
    ::stage <- 0;
}

function update(){
    ::testVal += 0.01;

    if(stage == 0){
        ::prog.setNamedConstant("firstVal", testVal);
    }
    else if(stage == 1){
        ::prog.setNamedConstant("secondVal", Vec3(testVal, testVal, testVal));
    }
    else if(stage == 2){
        ::prog.setNamedConstant("thirdVal", Vec2(testVal, testVal));
    }
    else if(stage == 3){
        ::prog.setNamedConstant("colourVal", ColourValue(testVal, testVal, testVal, 1));
    }
    else if(stage == 4){
        _test.endTest();
    }

    if(::testVal >= 1.0){
        ::testVal = 0;
        ::stage++;
    }
    ::prog.setNamedConstant("stage", ::stage);
    print(testVal);
}