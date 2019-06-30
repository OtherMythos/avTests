//A test to check that shifting the origin moves meshes created by the mesh manager.

function arrayEqual(first, second){
    _test.assertEqual(first[0], second[0]);
    _test.assertEqual(first[1], second[1]);
    _test.assertEqual(first[2], second[2]);
}

function start(){
    _world.createWorld();

    local targetPos = SlotPosition(0, 0, 20, 0, 20);

    local mesh = _mesh.create("ogrehead2.mesh");
    mesh.setPosition(targetPos);

    _camera.setPosition(0, 0, 200);
    _camera.lookAt(0, 0, 0);

    arrayEqual(mesh.getPositionRaw(), [20, 0, 20]);

    //The origin is now over where the mesh was created, this means the mesh itself should be shifted to 0, 0, 0.
    _slotManager.setOrigin(targetPos);

    arrayEqual(mesh.getPositionRaw(), [0, 0, 0]);

    //--
    //Same as -50, -50, as the slot size is 50.
    _slotManager.setOrigin(SlotPosition(-1, -1));

    //So the 20 offset and the 50 should make 70.
    arrayEqual(mesh.getPositionRaw(), [70, 0, 70]);

    _test.endTest();
}

function update(){
}
