//A test which checks the setLinearVelocity function of rigid bodies.

function start(){
    _doFile("res:///../../../Resources/scripts/physicsScripts.nut");

    _world.createWorld();

    _camera.setPosition(0, 0, 200);
    _camera.lookAt(0, 0, 0);

    ::stage <- 0;
    ::stageCount <- 0;

    ::mesh <- _mesh.create("cube");
    local shape = _physics.getCubeShape(1, 1, 1);
    ::body <- _physics.dynamics.createRigidBody(shape);
    mesh.attachRigidBody(body);

    ::floor <- _physics.dynamics.createRigidBody(shape,
        {"mass": 0, "origin": [0, -10, 0]} // x 1, slightly off so that it falls through.
    );
    _physics.dynamics.addBody(body);
    _physics.dynamics.addBody(floor);

    //By setting the linear velocity the cube will miss the floor and continue to fall.
    body.setLinearVelocity(Vec3(10, 0, 0));
}

function update(){
    local pos = mesh.getPosition();
    if(pos.y < -20){
        _test.endTest();
    }
}
