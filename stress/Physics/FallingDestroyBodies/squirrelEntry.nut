function start(){
    _world.createWorld();

    _camera.setPosition(0, 60, 120);
    _camera.lookAt(20, 0, 20);

    ::meshesContainer <- [];

}

function createCubeShape(){
    local x = rand().tofloat() / RAND_MAX;
    local y = rand().tofloat() / RAND_MAX;
    local z = rand().tofloat() / RAND_MAX;
    //Make sure it has a minimum size of 0.1.
    x += 0.1;
    y += 0.1;
    z += 0.1;
    //Create a different shape for each using a random number.
    //This is intended to stress the shape creation procedure, as each shape should be different enough to cause it to create lots.
    local shape = _physics.getCubeShape(x, y, z);

    local mesh = _mesh.create("cube");
    local body = _physics.dynamics.createRigidBody(shape, {"origin": [0, 0, 0]});
    mesh.setScale(x, y, z);
    mesh.attachRigidBody(body);

    _physics.dynamics.addBody(body);

    //The mesh should be the only thing that holds a reference to the body. Therefore when the mesh is destroyed the body and the shape should be destroyed.
    meshesContainer.push(mesh);
}

function removeEntry(){
    //Remove a random shape from the list
    local val = ((rand().tofloat() / RAND_MAX) * meshesContainer.len()).tointeger();

    //This should remove all references to the body and the shape, so they should be destroyed.
    meshesContainer.remove(val);
}

function update(){
    createCubeShape();
    removeEntry();
}
