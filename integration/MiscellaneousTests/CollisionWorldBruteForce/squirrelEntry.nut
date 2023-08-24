//A test to check that CollisionWorld objects can be created and used for the brute force method.

function start(){
    local world = CollisionWorld(_COLLISION_WORLD_BRUTE_FORCE);

    local failed = false;
    try{
        local otherWorld = CollisionWorld(-1);
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    local addedPointFirst = world.addCollisionPoint(10, 10, 1);
    local addedPointSecond = world.addCollisionPoint(10.5, 10, 1);

    world.processCollision();
    _test.assertEqual(world.getNumCollisions(), 1);
    //print(world.getCollisionPairForIdx(0));
    local collisionStatus = (world.getCollisionPairForIdx(0) & 0xF000000000000000) >> 60;
    local pair = (world.getCollisionPairForIdx(0) & 0x0FFFFFFFFFFFFFFF);
    _test.assertEqual(collisionStatus, 0x1);
    _test.assertTrue((pair&0xFFFFFFF) == 1 || pair >> 30 == 1);
    _test.assertTrue((pair&0xFFFFFFF) == 0 || pair >> 30 == 0);

    for(local i = 0; i < 5; i++){
        world.processCollision();
        _test.assertEqual(world.getNumCollisions(), 1);
        local collisionStatus = (world.getCollisionPairForIdx(0) & 0xF000000000000000) >> 60;
        local pair = world.getCollisionPairForIdx(0) & 0xFFFFFFFFFFFFF;

        _test.assertEqual(collisionStatus, 0x0);
        _test.assertTrue((pair&0xFFFFFFF) == 1 || pair >> 30 == 1);
        _test.assertTrue((pair&0xFFFFFFF) == 0 || pair >> 30 == 0);
    }

    //Move the point and check the collision left message is registered.
    world.setPositionForPoint(addedPointFirst, 5, 5);
    world.processCollision();
    _test.assertEqual(world.getNumCollisions(), 1);

    local collisionStatus = (world.getCollisionPairForIdx(0) & 0xF000000000000000) >> 60;
    local pair = world.getCollisionPairForIdx(0) & 0xFFFFFFFFFFFFF;
    _test.assertEqual(collisionStatus, 0x2);
    _test.assertTrue((pair&0xFFFFFFF) == 1 || pair >> 30 == 1);
    _test.assertTrue((pair&0xFFFFFFF) == 0 || pair >> 30 == 0);

    _test.endTest();
}
