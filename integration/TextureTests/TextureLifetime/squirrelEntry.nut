//A test to check memory management of movableTexture objects.
//This checks the reference counting and general destruction procedure.

function start(){
}

function update(){
    //Creation and destruction
    {
        _test.assertEqual(_test.texture.getNumTextures(), 0);
        local tex = MovableTexture("cat1.jpg");
        _test.assertEqual(_test.texture.getNumTextures(), 1);
        tex = 0;
        _test.assertEqual(_test.texture.getNumTextures(), 0);
    }

    //Assignment
    {
        local tex1 = MovableTexture("cat1.jpg");
        _test.assertEqual(_test.texture.getNumTextures(), 1);
        local tex2 = MovableTexture("cat2.jpg");
        _test.assertEqual(_test.texture.getNumTextures(), 2);

        local tex3 = tex1;
        _test.assertEqual(_test.texture.getNumTextures(), 2);
        tex1 = 0; //cat1 shouldn't be deleted here as a reference is still held in tex3
        _test.assertEqual(_test.texture.getNumTextures(), 2);
        tex2 = tex3; //Now cat2 has no references, so should be deleted.
        _test.assertEqual(_test.texture.getNumTextures(), 1);
        tex3 = 0;
        _test.assertEqual(_test.texture.getNumTextures(), 1);
        tex1 = 0;
        _test.assertEqual(_test.texture.getNumTextures(), 1);
    }

    _test.endTest();

}
