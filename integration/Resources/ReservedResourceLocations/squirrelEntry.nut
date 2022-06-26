//A test to check internal resource locations specified by the user are rejected by the engine as expected.

function start(){

    //Should be able to load cat2 but not cat1, as cat1 was specified in the internal group, i.e banned.
    local texture = MovableTexture("cat2.jpg", "notInternal");
    _test.assertEqual(_test.texture.getNumTextures(), 1);

    local failed = false;
    try{
        local texture = MovableTexture("cat1.jpg", "internal/test");
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    _test.endTest();
}