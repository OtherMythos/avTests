//A test to check a body landing on a static one is reported once, and with the right details.

function start(){
    _doFile("res://../../../Resources/scripts/physicsScripts.nut");
    _doFile("res://../../../Resources/scripts/physicsImpactScripts.nut");

    ::stage <- 0;
    ::stageCount <- 0;

    _physics.dynamics.setImpactThreshold(impactThreshold);

    ::ground <- createImpactFloor();
    ::body <- createImpactBody(2, impactDropHeight, 3);
}

function update(){
    local impacts = _physics.dynamics.getImpacts();

    if(stage == 0){
        if(impacts.len() > 0){
            _test.assertEqual(impacts.len(), 1);

            local impact = impacts[0];
            assertImpactBetween(impact, ground, body);
            assertImpactStrengthOfDrop(impact);

            //Under the body. Allowing for it having sunk in by up to a step's travel at the slowest update rate.
            _test.assertTrue(fabs(impact.pos.x - 2) <= 0.5);
            _test.assertTrue(fabs(impact.pos.z - 3) <= 0.5);
            _test.assertTrue(fabs(impact.pos.y) < 0.15);

            stage++;
            return;
        }
        if(stationary(body.getPosition())){
            //It landed without being reported.
            _test.endTest(false);
        }
    }
    if(stage == 1){
        //Nothing else as it comes to rest, or once it's there.
        _test.assertEqual(impacts.len(), 0);
        if(stationary(body.getPosition())){
            stage++;
        }
    }
    if(stage == 2){
        _test.assertEqual(impacts.len(), 0);
        stageCount++;
        if(stageCount >= 30){
            _test.endTest();
        }
    }
}
