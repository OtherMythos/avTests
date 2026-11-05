//A test to check bodies landing at the same time are each reported.

function start(){
    _doFile("res://../../../Resources/scripts/physicsScripts.nut");
    _doFile("res://../../../Resources/scripts/physicsImpactScripts.nut");

    _physics.dynamics.setImpactThreshold(impactThreshold);

    ::ground <- createImpactFloor();
    ::first <- createImpactBody(-3, impactDropHeight, 0);
    ::second <- createImpactBody(3, impactDropHeight, 0);
}

function update(){
    local impacts = _physics.dynamics.getImpacts();

    if(impacts.len() > 0){
        _test.assertEqual(impacts.len(), 2);

        //Matched by where they landed, as the list is in no particular order.
        local left = impacts[0].pos.x < 0 ? impacts[0] : impacts[1];
        local right = impacts[0].pos.x < 0 ? impacts[1] : impacts[0];
        assertImpactBetween(left, ground, first);
        assertImpactBetween(right, ground, second);

        _test.endTest();
    }
    if(stationary(first.getPosition())){
        _test.endTest(false);
    }
}
