//A test which checks custom user settings appear in the setup file.

function start(){

    local values = _graphics.getLoadedTextures();
    foreach(i in values){
        print(i);
    }

    _test.assertTrue(values.find("extraFirstTexture.jpg") != null);
    _test.assertTrue(values.find("extraSecondTexture.jpg") != null);

    //Included as part of the regular ogre file.
    _test.assertTrue(values.find("cat2.jpg") != null);

    _test.endTest();
}
