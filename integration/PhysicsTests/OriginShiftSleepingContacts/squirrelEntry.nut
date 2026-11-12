function start(){
    _doFile("res://../../../Resources/scripts/physicsOriginScripts.nut");
    _doFile("res://../../../Resources/scripts/physicsImpactScripts.nut");
    ::updates <- 0;
    ::stage <- 0;
    ::shifts <- 0;
    ::total <- Vec3();
    ::initialShifts <- _physics.dynamics.getStats().shifts;
    ::ground <- createImpactFloor();
    ::body <- createImpactBody(2, 0, 3);
    ::identity <- body.getInternalId();
}

function update(){
    _test.assertTrue(++updates < 2000);
    local stats = _physics.dynamics.getStats();
    local impacts = _physics.dynamics.getImpacts();
    if(stage == 0){
        if(stats.dynamicBodies != 1 || stats.awakeBodies != 0) return;
        ::resting <- body.getPosition();
        _physics.dynamics.setImpactThreshold(0);
        stage = 1;
    }
    if(stage == 1){
        _test.assertEqual(impacts.len(), 0);
        _test.assertEqual(stats.awakeBodies, 0);
        assertOriginPosition(body.getPosition(), resting - total);
        if(stats.shifts != initialShifts + shifts) return;
        if(shifts < 8){
            local delta = Vec3(128, 16, -256);
            _physics.dynamics.shiftOrigin(delta);
            total = total + delta;
            shifts++;
            assertOriginPosition(body.getPosition(), resting - total);
            return;
        }
        _physics.dynamics.setImpactThreshold(impactThreshold);
        body.setPosition(resting - total + Vec3(0, 2, 0));
        stage = 2;
        return;
    }
    if(stage == 2 && impacts.len() > 0){
        _test.assertEqual(impacts.len(), 1);
        local hit = impacts[0];
        assertImpactBetween(hit, ground, body);
        assertImpactStrengthOfDrop(hit);
        _test.assertTrue(fabs(hit.pos.x - (2 - total.x)) < 0.6);
        _test.assertTrue(fabs(hit.pos.z - (3 - total.z)) < 0.6);
        _test.assertTrue(fabs(hit.pos.y + total.y) < 0.2);
        _test.assertEqual(body.getInternalId(), identity);
        _physics.dynamics.shiftOrigin(total * -1);
        local translated = _physics.dynamics.getImpacts();
        _test.assertEqual(translated.len(), 1);
        assertOriginPosition(translated[0].pos, hit.pos + total);
        _test.assertEqual(translated[0].strength, hit.strength);
        stage = 3;
        ::quietUpdates <- 0;
        return;
    }
    if(stage == 3){
        _test.assertEqual(impacts.len(), 0);
        if(++quietUpdates > 20){
            _test.assertTrue(fabs(body.getPosition().y - resting.y) < 0.1);
            _test.endTest();
        }
    }
}
