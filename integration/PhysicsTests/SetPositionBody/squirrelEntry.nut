//A test to check that the rigid body function setPosition operates as intended.

function start(){
    _world.createWorld();

    _camera.setPosition(0, 0, 200);
    _camera.lookAt(0, 0, 0);

    ::stage <- 0;
    ::stageCount <- 0;

    ::mesh <- _mesh.create("ogrehead2.mesh");
    local shape = _physics.getCubeShape(1, 1, 1);
    ::body <- _physics.dynamics.createRigidBody(shape);
    mesh.attachRigidBody(mesh);

    _physics.dynamics.addBody(body);
}

function update(){
    if(stage == 0){
        if(mesh.getPosition().y < -100){
            //Back to the origin
            body.setPosition(SlotPosition());
            //_test.assertEqual(mesh.getPosition(), SlotPosition());

            stageCount = 0;
            stage++;
        }
    }
    if(stage == 1){
        //TODO at the moment I have to give it a few frames grace period for the mesh to get caught up with the body again.
        //Right now there's no immediate way to check the position of the body (issues with threading).
        //This might change in the future, and this can be updated.
        stageCount++;
        if(stageCount > 5){
            stageCount = 0;
            stage++;
        }
    }
    if(stage == 2){
        stageCount++;

        //The rigid body should have moved with the mesh
        if(mesh.getPosition().y < -100){
            _test.endTest(false);
        }
        //Check that it doesn't revert back to any stale data, and just starts falling from where it was positioned.
        if(stageCount >= 20){
            _test.endTest();
        }
    }
}
