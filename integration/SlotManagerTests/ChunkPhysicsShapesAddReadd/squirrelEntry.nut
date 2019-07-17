//A test to check that chunks can add and re-add physics objects.

class testFallingBody{
    mesh = null;
    shape = null;
    body = null;

    previousMeshPosition = null;
    stationaryCount = 0;

    constructor(constructionInfo, meshName){
        mesh = _mesh.create(meshName);
        shape = _physics.getCubeShape(1, 1, 1);
        body = _physics.dynamics.createRigidBody(shape, constructionInfo);

        _physics.dynamics.addBody(body);
        mesh.attachRigidBody(body);

        previousMeshPosition = mesh.getPosition();
    }

    function getPosition(){
        return mesh.getPosition();
    }

    function stoppedFalling(minYVal){
        local meshPos = mesh.getPosition();
        if(meshPos.equals(previousMeshPosition)){
            stationaryCount++;
            if(stationaryCount >= 10){
                return true
            }
        }else{
            //The mesh has moved since the last call to this function. Reset the stationary counter.
            stationaryCount = 0;
        }

        if(meshPos.y < minYVal){
            //The shape fell through the shape chunk, so fail.
            _test.endTest(false);
        }

        previousMeshPosition = meshPos;

        return false;
    }
}

function start(){
    _world.createWorld();
    _world.setPlayerLoadRadius(1);
    _slotManager.setCurrentMap("physicsTestMap");

    _camera.setPosition(0, 0, 200);
    _camera.lookAt(0, 0, 0);

    ::firstBody <- testFallingBody({"mass": 1, "origin": [0, 20, 0]}, "cube");
    //Created a bit away from the origin to test physics chunk shapes can created away from the origin.
    ::secondBody <- testFallingBody({"mass": 1, "origin": [40, 20, 40]}, "cube");
    //This one should just fall straight though, as there is no chunk body to catch it.
    ::thirdBody <- testFallingBody({"mass": 1, "origin": [20, 20, 20]}, "cube");

    ::stage <- 0;
}

function update(){
    if(stage == 0){
        if(firstBody.stoppedFalling(-50) && secondBody.stoppedFalling(-50)){
            stage++;
        }
    }
    if(stage == 1){
        //The physics chunk should be unloaded.
        _world.setPlayerPosition(SlotPosition(2, 2));

        firstBody = 0;
        secondBody = 0;

        ::firstBody <- testFallingBody({"mass": 1, "origin": [0, 20, 0]}, "cube");
        ::secondBody <- testFallingBody({"mass": 1, "origin": [40, 20, 40]}, "cube");

        stage++;
    }
    if(stage == 2){
        //Check this rigid body falls through the floor.
        if(firstBody.getPosition().y < -40 &&
            secondBody.getPosition().y < -40 &&
            thirdBody.getPosition().y < -40){
            _test.endTest();
        }
    }

}
