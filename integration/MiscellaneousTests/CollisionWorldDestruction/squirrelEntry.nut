//A test to check collision worlds are destroyed correctly.

function start(){
    local world = CollisionWorld(_COLLISION_WORLD_BRUTE_FORCE);

    //Check neither points trigger.
    local addedPointFirst = world.addCollisionPoint(10, 10, 1, 0x1);
    local addedPointSecond = world.addCollisionPoint(10.5, 10, 1, 0x2);

    world.processCollision();
    _test.assertEqual(world.getNumCollisions(), 0);

    world = null;

    world = CollisionWorld(_COLLISION_WORLD_BRUTE_FORCE);

    _test.endTest();
}
