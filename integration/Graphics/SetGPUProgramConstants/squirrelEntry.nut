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
    ::boolToggle <- false;
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
        local b = blob(4*4);
        b.writen(::testVal, 'f');
        b.writen(0.4, 'f');
        b.writen(0.8, 'f');
        b.writen(1.0, 'f');
        ::prog.setNamedConstant("array", b);
    }
    else if(stage == 5){
        if(testVal > 0.5) boolToggle = true;
        print("Bool value: " + boolToggle);
        ::prog.setNamedConstant("boolValue", boolToggle);
    }
    else if(stage == 6){
        //Set some float values
        local b = blob(4*4);
        b.writen(::testVal, 'f');
        b.writen(0.4, 'f');
        b.writen(0.8, 'f');
        b.writen(1.0, 'f');
        ::prog.setNamedConstant("arrayLenFourFloat", b);
    }
    else if(stage == 7){
        //Check a short blob works fine.
        local b = blob(4*1);
        b.writen(::testVal, 'f');
        ::prog.setNamedConstant("arrayLenFourFloat", b);

    }
    else if(stage == 8){
        //Check a larger blob fails.
        local b = blob(8*4);
        b.writen(0.8, 'f');
        b.writen(::testVal, 'f');
        b.writen(0.3, 'f');
        b.writen(1.0, 'f');
        b.writen(0.5, 'f');
        local failed = false;
        try{
            ::prog.setNamedConstant("arrayLenFourFloat", b);
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
    }
    else if(stage == 9){
        //integer blob.
        local b = blob(4*4);
        b.writen(1, 'i');
        b.writen(::testVal * 4, 'i');
        b.writen(2, 'i');
        b.writen(3, 'i');
        ::prog.setNamedConstant("arrayLenFourInt", b);
    }
    else if(stage == 10){
        //unsigned integer blob.
        local b = blob(4*4);
        b.writen(1, 'i');
        b.writen(::testVal * 4, 'i');
        b.writen(2, 'i');
        b.writen(3, 'i');
        ::prog.setNamedConstant("arrayLenFourIntUnsigned", b);
    }
    else if(stage == 11){
        //Float4 blob.
        local blobSize = 4*4*4;
        local b = blob(blobSize);
        b.writen(0.5, 'f');
        b.writen(0.0, 'f');
        b.writen(0.0, 'f');
        b.writen(1.0, 'f');
        ::prog.setNamedConstant("arrayLenFourFloat4", b);
    }
    else if(stage == 12){
        //Set values that aren't arrays with blobs.
        local b = blob(4);
        b.writen(0.5, 'f');
        ::prog.setNamedConstant("firstVal", b);
    }
    else if(stage == 13){
        _test.endTest();
    }

    if(::testVal >= 1.0){
        ::testVal = 0;
        ::stage++;
    }
    ::prog.setNamedConstant("stage", ::stage);
    print(testVal);
}