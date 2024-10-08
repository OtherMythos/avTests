function start(){
    _world.createWorld();

    _camera.setPosition(0, 60, 120);
    _camera.lookAt(20, 0, 20);

    //number of cubes in a single axis.
    ::numCubes <- 8;
    ::startTime <- _time();

    ::cubeShape <- _physics.getCubeShape(1, 1, 1);
    ::meshesContainer <- [];
    meshesContainer.resize(numCubes * numCubes * numCubes);

    //Add a big shape to represent the ground
    ::groundShape <- _physics.getCubeShape(100, 1, 100);
    ::groundBody <- _physics.dynamics.createRigidBody(groundShape, {"mass": 0});
    _physics.dynamics.addBody(groundBody);

    ::setup <- false;

    //setupScene();
}

function setupScene(){
    if(setup) return;

    local constructionInfo = {"origin": [0, 0, 0]};
    local index = 0;

    for(local z = 0; z < numCubes; z++){
        for(local y = 0; y < numCubes; y++){
            for(local x = 0; x < numCubes; x++){
                constructionInfo["origin"] = [x * 5, (y * 5) + 50, z * 5];
                local body = _physics.dynamics.createRigidBody(cubeShape, constructionInfo);
                local mesh = _mesh.create("cube");
                mesh.attachRigidBody(body);

                meshesContainer[index] = mesh;
                _physics.dynamics.addBody(body);
                index++;
            }
        }
    }
    setup = true;
}

function teardownScene(){
    if(!setup) return;

    for(local i = 0; i < meshesContainer.len(); i++){
        //This should also delete the rigid body and remove it from the world, as it has no more references.
        meshesContainer[i] = null;
    }
    setup = false;
}

function update(){
    local timeDiff = _time() - ::startTime;
    if(timeDiff >= 1 && timeDiff < 20){
        //After 1 second create everything
        setupScene();
    }
    if(timeDiff >= 20){
        //Start again.
        teardownScene();
        startTime = _time()
    }

}
