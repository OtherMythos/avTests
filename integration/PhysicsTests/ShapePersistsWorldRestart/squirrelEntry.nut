//Previously you weren't able to create shapes unless the world existed.
//That restriction has been lifted, and this test just checks that shapes can be created without a world, as well as when there is one, and that it persists between world restarts.

function start(){
    ::first <- _physics.getCapsuleShape(1, 2);
    _test.assertTrue(_test.physics.getShapeExists(2, 1, 2, 0));
}

function update(){

    for(local i = 0; i < 5; i++){
        _world.createWorld();

        //Try getting the shape when there is a world...
        first = _physics.getCapsuleShape(i, 2);
        _test.assertTrue(_test.physics.getShapeExists(2, i, 2, 0));

        _world.destroyWorld();

        //As well as when there isn't.
        first = _physics.getCapsuleShape(i, 2);
        _test.assertTrue(_test.physics.getShapeExists(2, i, 2, 0));
    }

    _test.endTest();
}
