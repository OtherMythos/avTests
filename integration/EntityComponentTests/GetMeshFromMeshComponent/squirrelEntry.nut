//Check that a mesh can be correctly obtained from an entity's mesh component.

function start(){
    _world.createWorld();
}

function update(){
    local e = _entity.create(SlotPosition());

    local cubeMesh = _mesh.create("cube");
    _component.mesh.add(e, cubeMesh);

    //Check that we've obtained the same mesh back.
    _test.assertEqual(cubeMesh, _component.mesh.getMesh(e));

    _test.endTest();
}
