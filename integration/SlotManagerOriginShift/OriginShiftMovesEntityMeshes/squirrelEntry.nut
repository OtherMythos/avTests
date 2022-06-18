//A test to check that shifting the origin also moves entity meshes.

function start(){
    _world.createWorld();

    local targetPos = SlotPosition(0, 0, 20, 0, 20);

    ::en1 <- _entity.create(targetPos);
    local mesh = _mesh.create("ogrehead2.mesh");
    _component.mesh.add(en1, mesh);

    _camera.setPosition(0, 0, 200);
    _camera.lookAt(0, 0, 0);

    _test.assertEqual(mesh.getPositionVec3(), Vec3(20, 0, 20));

    //The origin is now over where the mesh was created, this means the mesh itself should be shifted to 0, 0, 0.
    _slotManager.setOrigin(targetPos);

    _test.assertEqual(mesh.getPositionVec3(), Vec3(0, 0, 0));

    //--
    //Same as -50, -50, as the slot size is 50.
    _slotManager.setOrigin(SlotPosition(-1, -1));

    //So the 20 offset and the 50 should make 70.
    _test.assertEqual(mesh.getPositionVec3(), Vec3(70, 0, 70));

    _test.endTest();
}

function update(){
}
