//A test to check that chunks can add and re-add physics objects.

function start(){
    _world.createWorld();
    _world.setPlayerLoadRadius(1);
    _slotManager.setCurrentMap("physicsTestMap");

    _camera.setPosition(0, 0, 200);
    _camera.lookAt(0, 0, 0);

	::mesh <- _mesh.create("ogrehead2.mesh");
	::previousPos <- mesh.getPosition();
	::previousCount <- 0;
    ::stage <- 0;

    ::constructionInfo <- {"mass": 1, "origin": [0, 20, 0]};
    ::shape <- _physics.getCubeShape(1, 1, 1);
    ::body <- _physics.dynamics.createRigidBody(shape, constructionInfo);
    _physics.dynamics.addBody(body);
    mesh.attachRigidBody(body);
}

function update(){
	local meshPos = mesh.getPosition();
    if(stage == 0){
        if(meshPos.y < -50){
    		//The shape fell through the shape chunk, so fail.
            _test.endTest(false);
        }

    	if(previousPos.equals(meshPos)){
    		previousCount++;
    	}else{
    		previousCount = 0;
    	}

    	if(previousCount >= 10){
    		//The shape has stayed still for 10 frames, so it is resting on the body on the ground.
            previousCount = 0;
    		stage++;
    	}

        previousPos = meshPos;
    }
    if(stage == 1){
        //The physics chunk should be unloaded.
        _world.setPlayerPosition(SlotPosition(2, 2));

        body = 0;
        mesh.detachRigidBody();
        //Create a new rigid body.
        body = _physics.dynamics.createRigidBody(shape, constructionInfo);
        _physics.dynamics.addBody(body);
        mesh.attachRigidBody(body);

        stage++;
    }
    if(stage == 2){
        //Check this rigid body falls through the floor.
        if(meshPos.y < -40){
            _test.endTest();
        }
    }

}
