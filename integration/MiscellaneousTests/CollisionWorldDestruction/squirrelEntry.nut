//A test to check collision worlds are destroyed correctly.

function process(worldType){
    local world = CollisionWorld(worldType);

    //Check neither points trigger.
    local addedPointFirst = world.addCollisionPoint(10, 10, 1, 0x1);
    local addedPointSecond = world.addCollisionPoint(10.5, 10, 1, 0x2);

    world.processCollision();
    _test.assertEqual(world.getNumCollisions(), 0);

    world = null;

    world = CollisionWorld(_COLLISION_WORLD_BRUTE_FORCE);

    _test.endTest();
}

function start(){

    foreach(i in [_COLLISION_WORLD_BRUTE_FORCE, _COLLISION_WORLD_OCTREE]){
        process(i);
    }

    _test.endTest();
}
