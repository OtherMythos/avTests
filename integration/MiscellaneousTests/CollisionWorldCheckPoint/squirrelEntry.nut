//A test to check that checkCollisionPoint tests a circle of the given radius, not a
//point, against circles, rectangles and rotated rectangles, for both world types.

function process(worldType){
    local world = CollisionWorld(worldType);

    world.addCollisionPoint(0, 0, 1);
    //1.2 from the centre: clear of the circle by 0.2.
    _test.assertFalse(world.checkCollisionPoint(1.2, 0, 0.0));
    _test.assertFalse(world.checkCollisionPoint(1.2, 0, 0.1));
    _test.assertTrue(world.checkCollisionPoint(1.2, 0, 0.3));

    //4 wide, 2 high: its right edge at x = 22.
    world.addCollisionRectangle(20, 0, 4, 2);
    _test.assertTrue(world.checkCollisionPoint(21.9, 0, 0.0));
    _test.assertFalse(world.checkCollisionPoint(22.5, 0, 0.4));
    _test.assertTrue(world.checkCollisionPoint(22.5, 0, 0.6));

    //The same rectangle turned a quarter turn: its edge at x = 41, its end at y = 22.
    world.addCollisionRotatedRectangle(40, 20, 4, 2, PI * 0.5);
    _test.assertTrue(world.checkCollisionPoint(40, 21.9, 0.0));
    _test.assertFalse(world.checkCollisionPoint(41.5, 20, 0.4));
    _test.assertTrue(world.checkCollisionPoint(41.5, 20, 0.6));
    _test.assertFalse(world.checkCollisionPoint(40, 22.5, 0.4));
    _test.assertTrue(world.checkCollisionPoint(40, 22.5, 0.6));
}

function start(){
    foreach(i in [_COLLISION_WORLD_BRUTE_FORCE, _COLLISION_WORLD_OCTREE]){
        process(i);
    }

    _test.endTest();
}
