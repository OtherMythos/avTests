//A test to check that CollisionWorld objects can be created and used for the brute force method.

function start(){
    local world = CollisionWorld(_COLLISION_WORLD_BRUTE_FORCE);

    //Check neither points trigger.
    local addedPointFirst = world.addCollisionPoint(10, 10, 1, 0x1);
    local addedPointSecond = world.addCollisionPoint(10.5, 10, 1, 0x2);

    world.processCollision();
    _test.assertEqual(world.getNumCollisions(), 0);

    //Remove and check with a matching mask.
    world.removeCollisionPoint(addedPointFirst);
    world.removeCollisionPoint(addedPointSecond);

    addedPointFirst = world.addCollisionPoint(10, 10, 1, 0x1);
    addedPointSecond = world.addCollisionPoint(10.5, 10, 1, 0x1);

    world.removeCollisionPoint(addedPointFirst);
    world.removeCollisionPoint(addedPointSecond);

    //Check without providing a mask it still works.
    addedPointFirst = world.addCollisionPoint(10, 10, 1);
    addedPointSecond = world.addCollisionPoint(10.5, 10, 1);

    world.processCollision();
    _test.assertEqual(world.getNumCollisions(), 1);

    _test.endTest();
}
