//A test to check nothing is reported until a threshold has been set.

function start(){
    _doFile("res://../../../Resources/scripts/physicsScripts.nut");
    _doFile("res://../../../Resources/scripts/physicsImpactScripts.nut");

    ::ground <- createImpactFloor();
    ::body <- createImpactBody(0, impactDropHeight, 0);
}

function update(){
    _test.assertEqual(_physics.dynamics.getImpacts().len(), 0);

    if(stationary(body.getPosition())){
        _test.endTest();
    }
}
