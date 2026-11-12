//A test to check the disabled physics world returns errors when phyiscs functions are called.

function start(){
}

function update(){

    local shapeError = false;
    try{
        local shape = _physics.getCubeShape(1, 1, 1);
    }catch(e){
        shapeError = true;
    }
    _test.assertTrue(shapeError);

    local thresholdError = false;
    try{
        _physics.dynamics.setImpactThreshold(0.5);
    }catch(e){
        thresholdError = true;
    }
    _test.assertTrue(thresholdError);

    local impactsError = false;
    try{
        _physics.dynamics.getImpacts();
    }catch(e){
        impactsError = true;
    }
    _test.assertTrue(impactsError);


    local shiftError = false;
    try{
        _physics.dynamics.shiftOrigin(Vec3());
    }catch(e){
        shiftError = true;
    }
    _test.assertTrue(shiftError);

    local statsError = false;
    try{
        _physics.dynamics.getStats();
    }catch(e){
        statsError = true;
    }
    _test.assertTrue(statsError);

    _test.endTest();
}
