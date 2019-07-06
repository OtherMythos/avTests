//Checks that the rigid body of a tracked entity is destroyed, while the rigid body of an untracked entity is left as is.

function start(){
    dofile(_settings.getDataDirectory() + "/../../../Resources/scripts/physicsScripts.nut");

    ::stage <- 0;

    _world.setPlayerLoadRadius(1);
    _world.createWorld();

    _camera.setPosition(0, 0, 100);
    _camera.lookAt(0, 0, 0);

    local shape = _physics.getCubeShape(1, 1, 1);

    ::trackedEn <- _entity.createTracked(SlotPosition());
    ::unTrackedEn <- _entity.create(SlotPosition(0, 0, 0, 20, 0));

    _component.mesh.add(trackedEn, "cube");
    _component.mesh.add(unTrackedEn, "cube");

    local bodyFirst = _physics.dynamics.createRigidBody(shape);
    bodyFirst.setPosition(SlotPosition(0, 0, 0, 20, 0));
    local bodySecond = _physics.dynamics.createRigidBody(shape, {"mass": 0});

    _component.rigidBody.add(unTrackedEn, bodyFirst);
    _component.rigidBody.add(trackedEn, bodySecond);

    _physics.dynamics.addBody(bodyFirst);
    _physics.dynamics.addBody(bodySecond);
}

function update(){
    local enPos = unTrackedEn.getPosition();
    if(stage == 0){
        if(stationary(enPos)){
            stage++;
        }
    }
    if(stage == 1){
        //The tracked entity should now be destroyed.
        _slotManager.setCurrentMap("someMap");
        unTrackedEn.setPosition(SlotPosition(0, 0, 0, 30, 0));

        stage++;
    }
    if(stage == 2){
        if(enPos.y < -40){
            //The tracked entity was destroyed on map change, along with its rigid body.
            _test.endTest();
        }
    }
}
