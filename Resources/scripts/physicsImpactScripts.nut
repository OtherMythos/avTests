//Helpers for the tests of _physics.dynamics.getImpacts.

::impactThreshold <- 0.5;
//Dropped from this high a body meets the floor at about 6.3, at any update rate.
::impactDropHeight <- 2.0;

//A static floor, with its top at y 0.
function createImpactFloor(){
    local body = _physics.dynamics.createRigidBody(_physics.getCubeShape(10, 1, 10), {"mass": 0, "origin": [0, -1, 0]});
    _physics.dynamics.addBody(body);
    return body;
}

//A unit cube with its underside this high off the floor.
function createImpactBody(x, height, z){
    local body = _physics.dynamics.createRigidBody(_physics.getCubeShape(0.5, 0.5, 0.5), {"mass": 1, "origin": [x, height + 0.5, z]});
    _physics.dynamics.addBody(body);
    return body;
}

//Put a resting body back up in the air, to fall again.
function raiseImpactBody(body, x, height, z){
    body.setPosition(Vec3(x, height + 0.5, z));
}

//The order of the two bodies in an impact means nothing.
function assertImpactBetween(impact, a, b){
    local first = a.getInternalId();
    local second = b.getInternalId();
    _test.assertTrue((impact.a == first && impact.b == second) || (impact.a == second && impact.b == first));
}

//Not exact, as what the solver reports depends on how far the body sank in before the step which found it.
function assertImpactStrengthOfDrop(impact){
    _test.assertTrue(impact.strength > 5.0 && impact.strength < 8.0);
}
