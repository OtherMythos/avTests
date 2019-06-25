//A test to check a mesh moves with an attached rigid body.

function start(){
    _world.createWorld();

    _camera.setPosition(0, 0, 200);
    _camera.lookAt(0, 0, 0);

    local shape = _physics.getCubeShape(1, 1, 1);


    local body = _physics.dynamics.createRigidBody(shape);
    _physics.dynamics.addBody(body);

    ::mesh <- _mesh.create("ogrehead2.mesh");
    mesh.attachRigidBody(body);
}

function update(){
    print(mesh.getPosition());
    if(mesh.getPosition().y < -50){
        _test.endTest();
    }
}
