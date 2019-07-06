//A test to check that physics chunks are shifted when an origin change happens.

function stationary(currentPos){
    if(currentPos.y < -50){
        //The shape fell through the shape chunk, so fail.
        _test.endTest(false);
    }

    if(previousPos.equals(currentPos)){
        previousCount++;
    }else{
        previousCount = 0;
    }

    if(previousCount >= 10){
        //The shape has stayed still for 10 frames, so it is resting on the body on the ground.
        previousCount = 0;
        return true;
    }

    previousPos = currentPos;

    return false;
}

function start(){
    _world.createWorld();
    _world.setPlayerLoadRadius(1);
    _slotManager.setCurrentMap("physicsTestMap");

    _camera.setPosition(0, 0, 200);
    _camera.lookAt(0, 0, 0);

	::entity <- _entity.create(SlotPosition());
	::previousPos <- entity.getPosition();
	::previousCount <- 0;
    ::stage <- 0;

    ::constructionInfo <- {"mass": 1, "origin": [0, 20, 0]};
    ::shape <- _physics.getCubeShape(1, 1, 1);
    ::body <- _physics.dynamics.createRigidBody(shape, constructionInfo);
    _physics.dynamics.addBody(body);
    _component.rigidBody.add(entity, body);
    _component.mesh.add(entity, "ogrehead2.mesh");
}

function update(){
	local enPos = entity.getPosition();
    if(stage == 0){
        if(stationary(enPos)){
            stage++;
        }
    }
    if(stage == 1){
        _slotManager.setOrigin(SlotPosition(0, 0, 20, 0, 20));
        entity.setPosition(SlotPosition(0, 0, 0, 50, 0));

        stage++;
    }
    if(stage == 2){
        if(stationary(enPos)){
            _test.endTest();
        }
    }

}
