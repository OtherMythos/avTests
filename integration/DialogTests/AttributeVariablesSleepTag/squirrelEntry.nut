//A test to check that local and global variables can be correctly assigned to tag attributes.
//This one only tests the sleep tag because it's more complex to test than the others.

function start(){
    ::currentString <- "";
    ::dialog <- _dialogSystem.compileDialog(_settings.getDataDirectory() + "/Dialog.dialog");
    ::stage <- 0;
}

function update(){
    //The time() function isn't that high resolution, however this doesn't need to be accurate.
    //It's really just checking if the variables are set correctly, and simple seconds demonstrate that.
    if(stage == 0){
        _registry.set("targetSleep", 1000);
        _dialogSystem.executeCompiledDialog(dialog, 0);
        _dialogSystem.update();
        ::startTime <- time();
        stage++;
    }
    if(stage == 1){
        if(::currentString != ""){
            print("second");
            _registry.set("targetSleep", 2000);
            _test.assertEqual( 1, (time() - ::startTime) );
            ::currentString = "";
            ::startTime <- time();
            _dialogSystem.unblock();
            stage++;
        }
    }
    if(stage == 2){
        if(::currentString != ""){
            print("third");
            _test.assertEqual( 2, (time() - ::startTime) );

            //The final sleep tag is just a constant, so should not use variables.
            ::currentString = "";
            ::startTime <- time();
            _dialogSystem.unblock();
            stage++;
        }
    }
    if(stage == 3){
        if(::currentString != ""){
            _test.assertEqual( 2, (time() - ::startTime) );

            _test.endTest();
        }
    }
}
