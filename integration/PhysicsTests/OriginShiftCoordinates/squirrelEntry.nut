function start(){
    _doFile("res://../../../Resources/scripts/physicsOriginScripts.nut");
    ::updates <- 0;
    ::initialShifts <- _physics.dynamics.getStats().shifts;
    ::body <- frozenOriginBody(Vec3(4096, 32, -8192));
    ::ground <- _physics.dynamics.createRigidBody(_physics.getCubeShape(1, 1, 1), {"mass": 0, "origin": [4100, 16, -8200]});
    _physics.dynamics.addBody(ground);
    ::identity <- body.getInternalId();
    _physics.dynamics.shiftOrigin(Vec3(4096, 32, -8192));
    assertOriginPosition(body.getPosition(), Vec3());
    assertOriginPosition(ground.getPosition(), Vec3(4, -16, -8));
    _physics.dynamics.shiftOrigin(-128, 16, 256);
    assertOriginPosition(body.getPosition(), Vec3(128, -16, -256));
    //A new body already uses the current coordinate frame.
    ::added <- frozenOriginBody(Vec3(3, 4, 5));
    _physics.dynamics.shiftOrigin(Vec3(128, -16, -256));
    assertOriginPosition(body.getPosition(), Vec3());
    assertOriginPosition(added.getPosition(), Vec3(-125, 20, 261));
}

function update(){
    _test.assertTrue(++updates < 100);
    assertOriginPosition(body.getPosition(), Vec3());
    assertOriginPosition(ground.getPosition(), Vec3(4, -16, -8));
    assertOriginPosition(added.getPosition(), Vec3(-125, 20, 261));
    _test.assertEqual(body.getInternalId(), identity);
    _test.assertTrue(body.inWorld());
    local stats = _physics.dynamics.getStats();
    if(stats.shifts == initialShifts + 3 && updates > 10){
        _test.assertEqual(stats.dynamicBodies, 2);
        _test.assertEqual(stats.staticBodies, 1);
        _test.endTest();
    }
}
