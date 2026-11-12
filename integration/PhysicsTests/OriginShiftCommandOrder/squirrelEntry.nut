function start(){
    _doFile("res://../../../Resources/scripts/physicsOriginScripts.nut");
    ::updates <- 0;
    ::initialShifts <- _physics.dynamics.getStats().shifts;
    ::before <- frozenOriginBody(Vec3(10, 20, 30));
    ::removed <- frozenOriginBody(Vec3(40, 50, 60));
    _physics.dynamics.removeBody(removed);
    _physics.dynamics.shiftOrigin(Vec3(128, 16, -256));
    ::after <- frozenOriginBody(Vec3(1, 2, 3));
    _physics.dynamics.addBody(removed);
    ::movedBefore <- frozenOriginBody(Vec3());
    movedBefore.setPosition(4, 5, 6);
    _physics.dynamics.shiftOrigin(Vec3(32, -8, 64));
    ::movedAfter <- frozenOriginBody(Vec3());
    movedAfter.setPosition(7, 8, 9);
    //Destruction must not leave a queued add or setter pointing at the freed body.
    local doomed = frozenOriginBody(Vec3());
    doomed.setPosition(100, 200, 300);
    doomed = null;
    _physics.dynamics.shiftOrigin(Vec3());
}

function update(){
    _test.assertTrue(++updates < 100);
    assertOriginPosition(before.getPosition(), Vec3(-150, 12, 222));
    assertOriginPosition(after.getPosition(), Vec3(-31, 10, -61));
    assertOriginPosition(removed.getPosition(), Vec3(8, 58, -4));
    assertOriginPosition(movedBefore.getPosition(), Vec3(-28, 13, -58));
    assertOriginPosition(movedAfter.getPosition(), Vec3(7, 8, 9));
    local stats = _physics.dynamics.getStats();
    if(stats.shifts == initialShifts + 3 && updates > 10){
        _test.assertEqual(stats.dynamicBodies, 5);
        _test.assertEqual(stats.staticBodies, 0);
        _test.endTest();
    }
}
