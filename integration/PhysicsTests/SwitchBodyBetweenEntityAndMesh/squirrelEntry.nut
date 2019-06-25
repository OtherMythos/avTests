//A test to switch the attachment of a rigid body between a mesh and an entity.

function start(){
    _world.createWorld();

    _camera.setPosition(0, 0, 200);
    _camera.lookAt(0, 0, 0);

    ::stage <- 0;
    ::finalCount <- 0;

    ::en <- _entity.create(SlotPosition());
    _component.mesh.add(en, "ogrehead2.mesh");

    local shape = _physics.getCubeShape(1, 1, 1);


    ::body <- _physics.dynamics.createRigidBody(shape);
    _physics.dynamics.addBody(body);

    ::mesh <- _mesh.create("ogrehead2.mesh");
    mesh.attachRigidBody(body);
}

function update(){
    if(stage == 0){
        if(mesh.getPosition().y < -50){
            stage++;

            mesh.detachRigidBody();
            _component.rigidBody.add(en, body);
        }
    }
    if(stage == 1){
        if(en.getPosition().y < -100){
            _component.rigidBody.remove(en);
            mesh.attachRigidBody(body);
            ::finalEntityPos <- en.getPosition();
            stage++;
        }
    }
    if(stage == 2){
        if(mesh.getPosition().y < -150){
            stage++;

            //Now have it be attached to nothing.
            mesh.detachRigidBody();
            ::finalMeshPos <- mesh.getPosition();
        }
    }
    if(stage == 3){
        finalCount++;

        //For 10 frames check neither the mesh nor the shape moves.
        _test.assertEqual(mesh.getPosition(), finalMeshPos);
        _test.assertEqual(en.getPosition(), finalEntityPos);

        if(finalCount >= 10){
            _test.endTest();
        }
    }
}
