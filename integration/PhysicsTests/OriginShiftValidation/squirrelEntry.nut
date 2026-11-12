function expectError(call){
    local failed = false;
    try{ call(); }catch(e){ failed = true; }
    _test.assertTrue(failed);
}

function start(){
    ::updates <- 0;
    ::initialShifts <- _physics.dynamics.getStats().shifts;
    local nan = sqrt(-1.0);
    local infinity = pow(10.0, 100.0);
    foreach(value in [nan, infinity, -infinity]){
        expectError(function(){ _physics.dynamics.shiftOrigin(value, 0, 0); });
        expectError(function(){ _physics.dynamics.shiftOrigin(0, value, 0); });
        expectError(function(){ _physics.dynamics.shiftOrigin(0, 0, value); });
        expectError(function(){ _physics.dynamics.shiftOrigin(Vec3(value, 0, 0)); });
        expectError(function(){ _physics.dynamics.shiftOrigin(Vec3(0, value, 0)); });
        expectError(function(){ _physics.dynamics.shiftOrigin(Vec3(0, 0, value)); });
    }
    expectError(function(){ _physics.dynamics.shiftOrigin(); });
    expectError(function(){ _physics.dynamics.shiftOrigin(1, 2); });
    expectError(function(){ _physics.dynamics.shiftOrigin(1, 2, 3, 4); });
    expectError(function(){ _physics.dynamics.shiftOrigin("wrong"); });
    expectError(function(){ _physics.dynamics.shiftOrigin([1, 2, 3]); });
    expectError(function(){ _physics.dynamics.shiftOrigin(1, "wrong", 3); });
    _physics.dynamics.shiftOrigin(Vec3());
    _physics.dynamics.shiftOrigin(0, 0, 0);
}

function update(){
    _test.assertTrue(++updates < 100);
    local stats = _physics.dynamics.getStats();
    if(stats.shifts == initialShifts + 2){
        _test.assertEqual(stats.dynamicBodies, 0);
        _test.assertEqual(stats.staticBodies, 0);
        _test.assertEqual(stats.awakeBodies, 0);
        _test.assertTrue(stats.steps > 0);
        _test.assertTrue(stats.stepMs >= 0);
        _test.endTest();
    }
}
