//A test to check the threshold decides what's reported, and can be changed as things run.

function start(){
    _doFile("res://../../../Resources/scripts/physicsScripts.nut");
    _doFile("res://../../../Resources/scripts/physicsImpactScripts.nut");

    ::stage <- 0;
    ::stageCount <- 0;
    ::reported <- 0;

    //Well above the speed it's going to land at.
    _physics.dynamics.setImpactThreshold(100);

    ::ground <- createImpactFloor();
    ::body <- createImpactBody(0, impactDropHeight, 0);
}

function dropAgain(threshold){
    _physics.dynamics.setImpactThreshold(threshold);
    raiseImpactBody(body, 0, impactDropHeight, 0);
    reported = 0;
    stage++;
}

function update(){
    local impacts = _physics.dynamics.getImpacts();
    reported += impacts.len();

    if(stage == 0){
        if(stationary(body.getPosition())){
            _test.assertEqual(reported, 0);

            //A body just resting isn't a hit, no matter how low this goes.
            _physics.dynamics.setImpactThreshold(0);
            stage++;
        }
    }
    else if(stage == 1){
        _test.assertEqual(impacts.len(), 0);
        stageCount++;
        if(stageCount >= 30){
            dropAgain(impactThreshold);
        }
    }
    else if(stage == 2){
        if(stationary(body.getPosition())){
            _test.assertEqual(reported, 1);
            //Negative switches it off while it's in use.
            dropAgain(-1);
        }
    }
    else if(stage == 3){
        if(stationary(body.getPosition())){
            _test.assertEqual(reported, 0);
            dropAgain(impactThreshold);
        }
    }
    else if(stage == 4){
        if(stationary(body.getPosition())){
            _test.assertEqual(reported, 1);
            _test.endTest();
        }
    }
}
