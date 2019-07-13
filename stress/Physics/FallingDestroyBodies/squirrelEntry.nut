function start(){
    _world.createWorld();

    _camera.setPosition(0, 60, 120);
    _camera.lookAt(20, 0, 20);

    ::meshesContainer <- [];

    ::count <- 0;

}

function generateNums(){
    local x = rand().tofloat() / RAND_MAX;
    local y = rand().tofloat() / RAND_MAX;
    local z = rand().tofloat() / RAND_MAX;
    //Make sure it has a minimum size of 0.1.
    x += 0.1;
    y += 0.1;
    z += 0.1;

    return [x, y, z];
}

function createCubeShape(){
    local size = generateNums();

    //Create a different shape for each using a random number.
    //This is intended to stress the shape creation procedure, as each shape should be different enough to cause it to create lots.
    local shape = _physics.getCubeShape(size[0], size[1], size[2]);

    local mesh = _mesh.create("cube");
    local body = _physics.dynamics.createRigidBody(shape, {"origin": [0, 0, 0]});
    mesh.setScale(size[0], size[1], size[2]);
    mesh.attachRigidBody(body);

    _physics.dynamics.addBody(body);

    //The mesh should be the only thing that holds a reference to the body. Therefore when the mesh is destroyed the body and the shape should be destroyed.
    meshesContainer.push(mesh);
}

function createUnusedCube(){
    //Unused shapes have a different destruction procedure from shapes that were attached, so it's worth testing that.
    //As the shapes here are only stored in local scope, they should be destroyed when the scope ends.
    local size = generateNums();
    local shape = _physics.getCubeShape(size[0], size[1], size[2]);
}

function removeEntry(){
    //Remove a random shape from the list
    local val = ((rand().tofloat() / RAND_MAX) * meshesContainer.len()).tointeger();

    //This should remove all references to the body and the shape, so they should be destroyed.
    if(count % 3 == 0){
        meshesContainer.remove(val);
    }
    count++;

    if(meshesContainer.len() > 50){

        //Doing the following two commands in a different order has a slightly different outcome on the final result.
        //It's a different usecase that should be tested each time.
        if(count % 2 == 0){
            print("Destroying world first.")
            _world.destroyWorld();
            meshesContainer.clear();
        }else{
            print("Clearing container first.")
            meshesContainer.clear();
            _world.destroyWorld();
        }

    }
    print(meshesContainer.len());
}

function update(){

    if(_world.ready()){
        createUnusedCube();
        createCubeShape();
        removeEntry();
    }else{
        _world.createWorld();
    }
}
