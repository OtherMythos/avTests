//This test creates an entity with a rigid body, and alternates between it being in and out of the world.
//By doing this the entity it is attached to should stop moving when the body is not in the world.

function start(){
    _world.createWorld();

    _camera.setPosition(0, 0, 200);
    _camera.lookAt(0, 0, 0);

    ::stageCount <- 0;
    ::stage <- 0;

    ::en <- _entity.create(SlotPosition());

    local shape = _physics.getCubeShape(1, 1, 1);
    ::body <- _physics.dynamics.createRigidBody(shape);


    //Create an entity and give it this body.
    _component.rigidBody.add(en, body);
    _component.mesh.add(en, "ogrehead2.mesh");
}

function update(){
    if(stage == 0){
        //Stage count counts how many times each stage happened.
        stageCount++;
        //Should start off at 50.
        _test.assertEqual(en.getPosition(), SlotPosition());

        if(stageCount >= 10) {
            stageCount = 0;
            stage++;
        }
    }
    if(stage == 1){
        //Now add the body.
        _physics.dynamics.addBody(body);

        stage++;
    }
    if(stage == 2){
        //The shape should now start falling.

        local pos = en.getPosition();
        print(pos.y);
        if(pos.y <= -50){
            //Make a note of this position.
            ::firstPos <- pos;
            _physics.dynamics.removeBody(body);
            stage++;
        }
    }
    if(stage == 3){
        stageCount++;

        //TODO there is currently a bug in the engine, not the test.
        //There is a single frame of logic difference between the body being added and the body being removed from the world.
        _test.assertEqual(en.getPosition(), firstPos);

        //Spend a few frames making sure the entity doesn't move.
        if(stageCount >= 50) {
            stageCount = 0;
            stage++;
        }
    }
    if(stage == 4){

    }

}
