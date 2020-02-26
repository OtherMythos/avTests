//A test to check that rigid bodies are removed from the world if all references to them are destroyed.

function start(){
    _doFile("res://../../../Resources/scripts/physicsScripts.nut");

    ::stage <- 0;

    _world.createWorld();

    _camera.setPosition(0, 0, 100);
    _camera.lookAt(0, 0, 0);

    //Create a body at the origin.
    ::shape <- _physics.getCubeShape(1, 1, 1);
    ::bodyFirst <- _physics.dynamics.createRigidBody(shape, {"mass": 0});

    ::fallBody <- _physics.dynamics.createRigidBody(shape, {"origin": [0, 20, 0]});
    ::fallMesh <- _mesh.create("cube");
    fallMesh.attachRigidBody(fallBody);

    _physics.dynamics.addBody(bodyFirst);
    _physics.dynamics.addBody(fallBody);
}

function update(){
    local fallPos = fallMesh.getPosition();
    if(stage == 0){
        if(stationary(fallPos)){
            //The falling body has hit the static body.

            //Remove references to the static body.
            //As there are no more referencs to it, it should now be removed from the world.
            delete ::bodyFirst;

            fallBody.setPosition(SlotPosition(0, 0, 0, 20, 0));

            stage++;
        }
    }
    if(stage == 1){
        //That body was removed, so the fall body should just fall through past the origin.
        if(fallPos.y < -40){
            _test.endTest();
        }
    }
}
