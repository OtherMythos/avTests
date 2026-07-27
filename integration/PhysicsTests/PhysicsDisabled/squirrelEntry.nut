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



    _test.endTest();
}
