function start(){

}

function update(){
    local first = _physics.getCubeShape(1, 1, 1);
    local second = _physics.getCubeShape(1, 1, 1);

    _test.assertEqual(first, second);

    local third = _physics.getCubeShape(2, 1, 1);

    _test.assertNotEqual(second, third);

    //Check with different shape types.
    local sphere = _physics.getSphereShape(3);
    _test.assertNotEqual(sphere, first);

    _test.endTest();
}
