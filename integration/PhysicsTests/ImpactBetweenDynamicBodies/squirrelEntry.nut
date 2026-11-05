//A test to check a hit between two moving bodies is reported between those two, rather than with what's underneath.
//The bodies have the same mass, so a strength which added the two together would read twice the drop and fail.

function start(){
    _doFile("res://../../../Resources/scripts/physicsScripts.nut");
    _doFile("res://../../../Resources/scripts/physicsImpactScripts.nut");

    ::stage <- 0;

    _physics.dynamics.setImpactThreshold(impactThreshold);

    ::ground <- createImpactFloor();
    ::under <- createImpactBody(0, 0, 0);
    ::top <- createImpactBody(0.1, 1 + impactDropHeight, 0);
}

function update(){
    local impacts = _physics.dynamics.getImpacts();

    if(stage == 0){
        if(impacts.len() > 0){
            _test.assertEqual(impacts.len(), 1);
            assertImpactBetween(impacts[0], under, top);
            assertImpactStrengthOfDrop(impacts[0]);
            stage++;
            return;
        }
        if(stationary(top.getPosition())){
            _test.endTest(false);
        }
    }
    if(stage == 1){
        if(stationary(top.getPosition())){
            _test.endTest();
        }
    }
}
