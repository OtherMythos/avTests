//A test to check that when an entity is moved, its mesh is moved along with it.

function start(){
    _world.createWorld();
}

function update(){
    local e = _entity.create(SlotPosition());
    //Create a mesh for this entity.
    local mesh = _mesh.create("cube");
    _component.mesh.add(e, mesh);

    local currentPos = mesh.getPositionRaw();
    //Should be at the origin.
    _test.assertEqual(currentPos[0], 0);
    _test.assertEqual(currentPos[1], 0);
    _test.assertEqual(currentPos[2], 0);

    //Move the entity.
    e.setPosition(SlotPosition(1, 1));

    currentPos = mesh.getPositionRaw();
    //Now should be at one chunk in (50x50)
    _test.assertEqual(currentPos[0], 50);
    _test.assertEqual(currentPos[1], 0);
    _test.assertEqual(currentPos[2], 50);

    e.setPosition(SlotPosition(-2, -2));

    currentPos = mesh.getPositionRaw();
    _test.assertEqual(currentPos[0], -100);
    _test.assertEqual(currentPos[1], 0);
    _test.assertEqual(currentPos[2], -100);


    _test.endTest();
}
