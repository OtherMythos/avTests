function start(){
    _doFile("res://../../../Resources/scripts/physicsOriginScripts.nut");
    ::updates <- 0;
    ::stage <- 0;
    ::stageUpdates <- 0;
    ::cycle <- 0;
    ::body <- frozenOriginBody(Vec3(10, 20, 30));
    ::expected <- Vec3(10, 20, 30);
}

function update(){
    _test.assertTrue(++updates < 200);
    local stats = _physics.dynamics.getStats();
    if(stage == 0 && stats.dynamicBodies == 1){
        _state.setPauseState(cycle == 0 ? _PAUSE_PHYSICS_DYNAMICS : _PAUSE_PHYSICS);
        stageUpdates = 0;
        stage = 1;
        return;
    }
    if(stage == 1 && ++stageUpdates > 5){
        ::pausedStats <- stats;
        local delta = Vec3(128, -16, 256);
        _physics.dynamics.shiftOrigin(delta);
        _physics.dynamics.shiftOrigin(32, 8, -64);
        expected = expected - delta - Vec3(32, 8, -64);
        assertOriginPosition(body.getPosition(), expected);
        stageUpdates = 0;
        stage = 2;
        return;
    }
    if(stage == 2){
        assertOriginPosition(body.getPosition(), expected);
        _test.assertEqual(stats.steps, pausedStats.steps);
        _test.assertEqual(stats.shifts, pausedStats.shifts);
        if(++stageUpdates > 10){
            _state.setPauseState(0);
            stage = 3;
            stageUpdates = 0;
        }
        return;
    }
    if(stage == 3){
        assertOriginPosition(body.getPosition(), expected);
        if(stats.shifts == pausedStats.shifts + 2 && ++stageUpdates > 5){
            if(++cycle == 2) _test.endTest();
            stage = 0;
        }
    }
}
