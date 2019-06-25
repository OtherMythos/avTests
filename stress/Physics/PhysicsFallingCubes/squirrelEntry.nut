function start(){
    _world.createWorld();

    _camera.setPosition(0, 50, 100);
    _camera.lookAt(0, 0, 0);

    //number of cubes in a single axis.
    ::numCubes <- 4;
    ::startTime <- time();

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
                local mesh = _mesh.create("ogrehead2.mesh");
                mesh.setScale(0.1, 0.1, 0.1);
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
    local timeDiff = time() - ::startTime;
    if(timeDiff >= 1 && timeDiff < 20){
        //After 1 second create everything
        setupScene();
    }
    if(timeDiff >= 20){
        //Start again.
        teardownScene();
        startTime = time()
    }

}
