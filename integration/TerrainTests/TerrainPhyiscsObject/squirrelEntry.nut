//A test to check that terrain physics bodies are created and destroyed after chunk load/unload.

function start(){
    _doFile("res://../../../Resources/scripts/physicsScripts.nut");

    _world.setPlayerLoadRadius(20);
    _world.createWorld();
    _slotManager.setCurrentMap("TerrainMapFilled");

    _camera.setPosition(20, 20, 100);
    _camera.lookAt(20, 0, 0);

    ::cubeShape <- _physics.getCubeShape(1, 1, 1);
    local body = _physics.dynamics.createRigidBody(cubeShape, {"origin": [20, 0, 20]});
    _physics.dynamics.addBody(body);
    ::mesh <- _mesh.create("cube");
    mesh.attachRigidBody(body);

    ::playerPos <- SlotPosition();
    ::stage <- 0;
    ::stageCount <- 0;
}

function update(){

    if(stage == 0){
        local fallPos = ::mesh.getPosition();
        if(fallPos.y < -30){
            //This means the cube has fallen through the terrain.
            _test.endTest(false);
        }
        stageCount++;
        if(stageCount >= 500){
            stage++;
            stageCount = 0;
        }
    }
    if(stage == 1){
        _world.setPlayerPosition(SlotPosition(1, 0, 25, 0, 25));

        //Here I re-create the body to avoid object sleeping.
        mesh.detachRigidBody();
        local body = _physics.dynamics.createRigidBody(cubeShape, {"origin": [70, 0, 20]});
        _physics.dynamics.addBody(body);
        mesh.attachRigidBody(body);
        _camera.setPosition(70, 20, 100);
        stage++;
    }
    if(stage == 2){
        local fallPos = ::mesh.getPosition();
        if(fallPos.y < -30){
            _test.endTest(false);
        }
        stageCount++;
        if(stageCount >= 500){
            _test.endTest();
        }
    }
}
