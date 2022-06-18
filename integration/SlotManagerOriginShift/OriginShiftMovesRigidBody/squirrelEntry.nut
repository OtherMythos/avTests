//A test to check that shifting the origin moves rigid bodies in the dynamics world.

function arrayEqual(first, second){
    _test.assertEqual(first.x, second[0]);
    //_test.assertEqual(first.y, second[1]);
    _test.assertEqual(first.z, second[2]);
}

function start(){
    _world.createWorld();

    ::stage <- 0;

    local targetPos = SlotPosition(0, 0, 20, 0, 20);
    ::en <- _entity.create(SlotPosition());

    ::mesh <- _mesh.create("ogrehead2.mesh");
    _component.mesh.add(en, mesh);

    _camera.setPosition(0, 0, 200);
    _camera.lookAt(0, 0, 0);

    local shape = _physics.getCubeShape(1, 1, 1);
    local body = _physics.dynamics.createRigidBody(shape);
    _physics.dynamics.addBody(body);

    _component.rigidBody.add(en, body);
}

function update(){
    print("entityPos: " + en.getPosition().y);
    if(stage == 0){
        arrayEqual(mesh.getPositionVec3(), [0, 0, 0]);

        if(en.getPosition().y < -20){
            _slotManager.setOrigin(SlotPosition(0, 0, 20, 0, 20));
            stage++;
        }
    }
    if(stage == 1){
        arrayEqual(mesh.getPositionVec3(), [-20, 0, -20]);

        if(en.getPosition().y < -40){
            _slotManager.setOrigin(SlotPosition(-1, -1, 20, 0, 20));
            stage++;
        }
    }
    if(stage == 2){
        //30 because each slot is 50 size, so if the origin is -1, 20, that becomes -30.
        arrayEqual(mesh.getPositionVec3(), [30, 0, 30]);

        if(en.getPosition().y < -60){
            stage++;
        }
    }
    if(stage == 3){
        _test.endTest();
    }
}
