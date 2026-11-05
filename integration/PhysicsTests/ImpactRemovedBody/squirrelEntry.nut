//A test to check bodies taken out of the world and added back are reported, under the right id.

function start(){
    _doFile("res://../../../Resources/scripts/physicsScripts.nut");
    _doFile("res://../../../Resources/scripts/physicsImpactScripts.nut");

    ::stage <- 0;
    ::stageCount <- 0;
    ::reported <- 0;

    _physics.dynamics.setImpactThreshold(impactThreshold);

    ::ground <- createImpactFloor();
    ::body <- createImpactBody(0, impactDropHeight, 0);
}

function checkImpacts(impacts, expectedBody){
    foreach(i in impacts){
        assertImpactBetween(i, ground, expectedBody);
    }
    reported += impacts.len();
}

function update(){
    local impacts = _physics.dynamics.getImpacts();

    if(stage == 0){
        checkImpacts(impacts, body);
        if(stationary(body.getPosition())){
            _test.assertEqual(reported, 1);
            reported = 0;

            _physics.dynamics.removeBody(body);
            stage++;
        }
    }
    else if(stage == 1){
        //Nothing from a body which isn't in the world.
        _test.assertEqual(impacts.len(), 0);
        stageCount++;
        if(stageCount >= 10){
            raiseImpactBody(body, 0, impactDropHeight, 0);
            _physics.dynamics.addBody(body);
            stage++;
        }
    }
    else if(stage == 2){
        checkImpacts(impacts, body);
        if(stationary(body.getPosition())){
            _test.assertEqual(reported, 1);
            reported = 0;

            ::newBody <- createImpactBody(4, impactDropHeight, 0);
            _test.assertNotEqual(newBody.getInternalId(), body.getInternalId());
            stage++;
        }
    }
    else if(stage == 3){
        checkImpacts(impacts, newBody);
        if(stationary(newBody.getPosition())){
            _test.assertEqual(reported, 1);
            _test.endTest();
        }
    }
}
