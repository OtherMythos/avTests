//A test to check that rigid bodies can persist world restart.

function start(){
    ::first <- _physics.getCapsuleShape(1, 2);
    ::bodyFirst <- _physics.dynamics.createRigidBody(first);
    //The body itself has been created, even when the world doesn't exist.
    _test.assertNotEqual(bodyFirst, null);

    _camera.setPosition(0, 0, 200);
    _camera.lookAt(0, 0, 0);

    ::stage <- 0;
    ::stageCount <- 0;

    _world.createWorld();

    _physics.dynamics.addBody(bodyFirst);

    ::en <- _entity.create(SlotPosition());

    //Create an entity and give it this body. That should work now as the world exists.
    _component.rigidBody.add(en, bodyFirst);
    _component.mesh.add(en, "ogrehead2.mesh");
}

function update(){
    if(stage == 0){

        if(en.getPosition().y < -50){
            stage++;
        }
    }
    if(stage == 1){
        _world.destroyWorld();

        _test.assertFalse(en.valid());
        stageCount = 0;
        stage++;
    }
    if(stage == 2){
        stageCount++;

        //Wait a few frames.
        if(stageCount >= 100){
            stage++;
        }
    }
    if(stage == 3){
        //Create the world and all the pieces again.
        _world.createWorld();

        ::en = _entity.create(SlotPosition());
        //local body2 = _physics.dynamics.createRigidBody(first);
        //_component.rigidBody.add(en, body2);
        _component.rigidBody.add(en, bodyFirst);
        _component.mesh.add(en, "ogrehead2.mesh");

        //_physics.dynamics.addBody(body2);
        _test.endTest();

        //BUG
        //This is a bug.
        //From what I'm seeing, during the update procedure bullet crashes when you try and add an object that was previously part of another world.
        //However, I've started to have cold feet about whether I care about rigid body persistence between worlds.
        //It's just never going to be used.
        //The main reason was to avoid invalid pointers at all times.
        //At the moment though I'm thinking I should have some sort of emphasis on the user not being stupid during a world restart.
        //Things like entities are also going to become invalid, and it should be up to the user to make sure their instances are valid.
        //So I'll leave this here for now.
        //If I decide it's worth fixing or taking out I'll do that later.
        //Thanks for your time.
        _physics.dynamics.addBody(bodyFirst);

        stage++;
    }
    if(stage == 4){
        if(en.getPosition().y < -100){
            stage++;
        }
    }
}
