//Check that destroying points still triggers collision leave events as expected.

function start(){
    local world = CollisionWorld(_COLLISION_WORLD_BRUTE_FORCE);

    local addedPointSender = world.addCollisionPoint(10, 10, 1, 0xFF, _COLLISION_WORLD_ENTRY_SENDER);
    local addedPointReceiver = world.addCollisionPoint(10.5, 10, 1, 0xFF, _COLLISION_WORLD_ENTRY_RECEIVER);

    {
        world.processCollision();
        //_test.assertEqual(world.getNumCollisions(), 1);
        //The two points should trigger a collision began event.

        local pair = world.getCollisionPairForIdx(0);
        local collisionStatus = (pair & 0xF000000000000000) >> 60;
        //_test.assertEqual(collisionStatus, 0x1);
    }

    {
        world.processCollision();
        _test.assertEqual(world.getNumCollisions(), 1);

        //Should all be 0 as the collision continued for the frame.
        local pair = world.getCollisionPairForIdx(0);
        local collisionStatus = (pair & 0xF000000000000000) >> 60;
        _test.assertEqual(collisionStatus, 0x0);
    }

    world.removeCollisionPoint(addedPointReceiver);

    {
        world.processCollision();
        //This is expected to be the leave event.
        _test.assertEqual(world.getNumCollisions(), 1);
        local pair = world.getCollisionPairForIdx(0);
        local collisionStatus = (pair & 0xF000000000000000) >> 60;
        _test.assertEqual(collisionStatus, 0x2);
    }

    {
        world.processCollision();
        _test.assertEqual(world.getNumCollisions(), 0);
    }

    _test.endTest();
}
