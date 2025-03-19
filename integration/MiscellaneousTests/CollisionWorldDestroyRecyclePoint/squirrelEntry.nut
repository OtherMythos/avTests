//Check that collision worlds hold onto point ids until the collision end event is properly delivered.
//If this does not happen destruction might conflict with newly created points.

function process(worldType){
    local world = CollisionWorld(worldType);

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

    world.removeCollisionPoint(addedPointReceiver);
    local newPoint = world.addCollisionPoint(10.5, 10, 1, 0xFF, _COLLISION_WORLD_ENTRY_RECEIVER);
    _test.assertNotEqual(newPoint, addedPointReceiver);

    {
        world.processCollision();
        _test.assertEqual(world.getNumCollisions(), 2);
        //We should get one entered and one leave event.

        local foundValues = {};

        for(local i = 0; i < 2; i++){
            local pair = world.getCollisionPairForIdx(i);
            local collisionStatus = (pair & 0xF000000000000000) >> 60;
            foundValues.rawset(collisionStatus, true);
        }
        _test.assertTrue(foundValues.rawin(0x1));
        _test.assertTrue(foundValues.rawin(0x2));
        _test.assertEqual(foundValues.len(), 2);
    }

    //Now the system has had an update and the leave event delivered, the previous hole should be used.
    local otherNewPoint = world.addCollisionPoint(10.5, 10, 1, 0xFF, _COLLISION_WORLD_ENTRY_RECEIVER);
    _test.assertEqual(otherNewPoint, addedPointReceiver);
}

function start(){

    foreach(i in [_COLLISION_WORLD_BRUTE_FORCE, _COLLISION_WORLD_OCTREE]){
        process(i);
    }

    _test.endTest();
}
