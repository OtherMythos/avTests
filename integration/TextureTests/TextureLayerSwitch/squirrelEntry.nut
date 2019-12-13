//A test to check that switching the layers of 2d textures works correctly.

function start(){
    _test.assertEqual(_test.texture.getNumTexturesForLayer(0), 0);

    local texture = MovableTexture("cat1.jpg");
    _test.assertEqual(_test.texture.getNumTextures(), 1);
    _test.assertEqual(_test.texture.getNumTexturesForLayer(1), 0);

    //We expect the texture to start on layer 0.
    _test.assertEqual(texture.getLayer(), 0);
    _test.assertEqual(_test.texture.getNumTexturesForLayer(0), 1);

    //Check the backend also agrees the texture is on layer 0.
    _test.assertTrue(_test.texture.isTextureInLayer(texture, 0));

    //Switch the texture to a different layer, and then check things update to reflect that.
    texture.setLayer(1);
    _test.assertEqual(texture.getLayer(), 1);
    _test.assertTrue(_test.texture.isTextureInLayer(texture, 1));

    _test.assertEqual(_test.texture.getNumTexturesForLayer(0), 0);
    _test.assertEqual(_test.texture.getNumTexturesForLayer(1), 1);

    //Finally switch it back.
    texture.setLayer(0);
    _test.assertEqual(texture.getLayer(), 0);
    _test.assertTrue(_test.texture.isTextureInLayer(texture, 0));

    _test.assertEqual(_test.texture.getNumTexturesForLayer(0), 1);
    _test.assertEqual(_test.texture.getNumTexturesForLayer(1), 0);


    _test.endTest();
}
