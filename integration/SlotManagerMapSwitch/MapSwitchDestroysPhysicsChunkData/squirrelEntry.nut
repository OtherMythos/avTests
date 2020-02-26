//A test to check that physics chunk data is correctly destroyed when switching maps.

function start(){
    _doFile("res://../../../Resources/scripts/physicsScripts.nut");

    ::stage <- 0;

    _world.setPlayerLoadRadius(1);
    _world.createWorld();

    _slotManager.setCurrentMap("physicsTestMap");

    _camera.setPosition(0, 0, 200);
    _camera.lookAt(0, 0, 0);

    ::mesh <- _mesh.create("ogrehead2.mesh");
    ::shape <- _physics.getCubeShape(1, 1, 1);
    ::body <- _physics.dynamics.createRigidBody(shape);
    body.setPosition(SlotPosition(0, 0, 0, 50, 0));
    mesh.attachRigidBody(body);
    _physics.dynamics.addBody(body);

    ::previousPos <- mesh.getPosition();
    ::previousCount <- 0;
}

function update(){
    local meshPos = mesh.getPosition();
    if(stage == 0){
        if(stationary(meshPos)){
            //The body has collided and is now resting on the ground.
            stage++;
        }
    }
    if(stage == 1){
        _slotManager.setCurrentMap("");
        body.setPosition(SlotPosition(0, 0, 0, 50, 0));

        stage++;
    }
    if(stage == 2){
        if(mesh.getPosition().y < -40){
            //The mesh continued to fall, meaning the body was destroyed.
            stage++;
        }
    }
    if(stage == 3){
        //Now bring that map back. The shape should once again collide with the ground.
        _slotManager.setCurrentMap("physicsTestMap");
        body.setPosition(SlotPosition(0, 0, 0, 50, 0));

        stage++;
    }
    if(stage == 4){
        if(stationary(meshPos)){
            _test.endTest();
        }
    }
}
