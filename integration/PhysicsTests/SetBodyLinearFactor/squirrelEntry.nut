//A test which checks the setLinearFactor function of rigid bodies.

function start(){
    _doFile("res://../../../Resources/scripts/physicsScripts.nut");

    _world.createWorld();

    _camera.setPosition(0, 0, 200);
    _camera.lookAt(0, 0, 0);

    ::stage <- 0;
    ::stageCount <- 0;

    ::mesh <- _mesh.create("cube");
    local shape = _physics.getSphereShape(1);
    ::body <- _physics.dynamics.createRigidBody(shape);
    mesh.attachRigidBody(body);
    //The linear factor means the shape can't roll when it otherwise would have.
    body.setLinearFactor(Vec3(0, 1, 0));

    ::floor <- _physics.dynamics.createRigidBody(shape,
        {"mass": 0, "origin": [1, -10, 0]} // x 1, slightly off so that it falls through.
    );
    _physics.dynamics.addBody(body);
    _physics.dynamics.addBody(floor);
}

function update(){
    if(stage == 0){
        local pos = mesh.getPosition();
        if(stationary(pos)){
            stage++;
        }
    }
    if(stage == 1){
        _test.endTest();
    }
}
