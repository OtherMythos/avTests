//A test to check that Collision world senders and receivers work as expected.

function start(){
    local world = CollisionWorld(_COLLISION_WORLD_BRUTE_FORCE);

    //Check neither points trigger.
    local addedPointFirst = world.addCollisionPoint(10, 10, 1, 0xFF, _COLLISION_WORLD_ENTRY_SENDER);
    local addedPointSecond = world.addCollisionPoint(10.5, 10, 1, 0xFF, _COLLISION_WORLD_ENTRY_RECEIVER);

    world.processCollision();
    _test.assertEqual(world.getNumCollisions(), 1);

    local pair = world.getCollisionPairForIdx(0);
    _test.assertTrue((pair & 0xFFFFFFF) == addedPointFirst);

    world.removeCollisionPoint(addedPointFirst);
    world.removeCollisionPoint(addedPointSecond);

    //Should be informed that these two collisions left.
    world.processCollision();
    _test.assertEqual(world.getNumCollisions(), 1);
    local pair = world.getCollisionPairForIdx(0);
    _test.assertTrue((pair & 0xFFFFFFF) == addedPointFirst);
    local collisionStatus = (pair & 0xF000000000000000) >> 60;
    _test.assertEqual(collisionStatus, 0x2);

    //If they're both senders you should get nothing.
    local addedPointFirst = world.addCollisionPoint(10, 10, 1, 0xFF, _COLLISION_WORLD_ENTRY_SENDER);
    local addedPointSecond = world.addCollisionPoint(10.5, 10, 1, 0xFF, _COLLISION_WORLD_ENTRY_SENDER);

    world.processCollision();
    _test.assertEqual(world.getNumCollisions(), 0);

    world.removeCollisionPoint(addedPointFirst);
    world.removeCollisionPoint(addedPointSecond);

    //Same check for receivers.
    local addedPointFirst = world.addCollisionPoint(10, 10, 1, 0xFF, _COLLISION_WORLD_ENTRY_RECEIVER);
    local addedPointSecond = world.addCollisionPoint(10.5, 10, 1, 0xFF, _COLLISION_WORLD_ENTRY_RECEIVER);

    world.processCollision();
    _test.assertEqual(world.getNumCollisions(), 0);

    _test.endTest();
}
