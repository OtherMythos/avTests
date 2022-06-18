//A test to check the movable texture api.

function start(){

    local texture = MovableTexture("cat1.jpg");
    _test.assertEqual(_test.texture.getNumTextures(), 1);

    texture.setPosition(100, 200);
    _test.assertEqual(texture.getPosition(), Vec2(100, 200));
    texture.setPosition(Vec2(200, 300));
    _test.assertEqual(texture.getPosition(), Vec2(200, 300));

    texture.setSize(Vec2(100, 200));
    _test.assertEqual(texture.getSize(), Vec2(100, 200));
    texture.setSize(200, 300);
    _test.assertEqual(texture.getSize(), Vec2(200, 300));

    texture.setTexture("cat1.jpg");
    texture.setTexture("cat1.jpg", "General");

    _test.endTest();
}
