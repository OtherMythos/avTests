function start(){
    _doFile("res://../../../Resources/scripts/physicsOriginScripts.nut");
    ::updates <- 0;
    ::shifts <- 0;
    ::total <- Vec3();
    ::initialShifts <- _physics.dynamics.getStats().shifts;
    ::entityBody <- frozenOriginBody(Vec3(8, 9, 10));
    ::meshBody <- frozenOriginBody(Vec3(-8, 9, -10));
    ::en <- _entity.create(Vec3(8, 9, 10));
    _component.rigidBody.add(en, entityBody);
    ::mesh <- _mesh.create("ogrehead2.mesh");
    mesh.attachRigidBody(meshBody);
}

function update(){
    _test.assertTrue(++updates < 150);
    if(shifts < 12){
        local delta = shifts % 2 == 0 ? Vec3(128, -16, 256) : Vec3(-64, 8, -128);
        _physics.dynamics.shiftOrigin(delta);
        total = total + delta;
        shifts++;
        assertOriginPosition(entityBody.getPosition(), Vec3(8, 9, 10) - total);
        assertOriginPosition(meshBody.getPosition(), Vec3(-8, 9, -10) - total);
        return;
    }
    if(_physics.dynamics.getStats().shifts == initialShifts + shifts && updates > 25){
        assertOriginPosition(en.getPosition(), Vec3(8, 9, 10) - total);
        assertOriginPosition(mesh.getPosition(), Vec3(-8, 9, -10) - total);
        _test.endTest();
    }
}
