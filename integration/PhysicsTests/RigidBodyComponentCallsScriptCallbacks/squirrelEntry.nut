//A test to check that movement from a rigid body component causes script callbacks.

function start(){
    _world.createWorld();

    _camera.setPosition(0, 0, 200);
    _camera.lookAt(0, 0, 0);

    ::movementCount <- 0;
    ::stage <- 0;

    local en = _entity.create(SlotPosition());

    local shape = _physics.getCubeShape(1, 1, 1);
    ::body <- _physics.dynamics.createRigidBody(shape);

    _physics.dynamics.addBody(body);

    //Create an entity and give it this body.
    _component.rigidBody.add(en, body);
    _component.mesh.add(en, "ogrehead2.mesh");

    _component.script.add(en, _settings.getDataDirectory() + "/EntityScript.nut");
}

function update(){
    if(stage == 0){
        if(movementCount >= 100){
            //Check that the gravity was applied correctly and the callback was called.
            _test.endTest();
        }
    }

}
