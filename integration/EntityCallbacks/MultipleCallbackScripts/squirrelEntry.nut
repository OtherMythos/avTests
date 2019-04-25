//Assign two scripts to two entities and check the scripts run their appropriate callbacks.

function start(){
    _world.createWorld();

    _camera.setPosition(0, 100, 100);
    _camera.lookAt(0, 0, 0);

    ::a <- _entity.create(SlotPosition());
    ::b <- _entity.create(SlotPosition());

    local scripts = ["/EntityScript.nut", "/SecondScript.nut"];
    foreach(i,e in [a, b]){
        _component.mesh.add(e, "ogrehead2.mesh");
        _component.script.add(e, _settings.getDataDirectory() + scripts[i]);
    }

    ::entityScore <- 0;
}

function moveEntities(){
    for(local i = 0; i < 10; i++){
        a.move(1, 0, 0);
        b.move(-1, 0, 0);
    }
}

function update(){
    //As the entity is moved about the score should change.
    _test.assertEqual(entityScore, 0);

    moveEntities();

    //Given how the two callbacks work against one another, we can assume that the entity score should stay at 0 by the end of this exercise.
    _test.assertEqual(entityScore, 0);

    //Remove the script that deducts and assign the scrip that increments.
    _component.script.remove(b);
    _component.script.add(b, _settings.getDataDirectory() + "/EntityScript.nut");

    moveEntities();

    //They're both incrementing the number now, so it should be 20.
    _test.assertEqual(entityScore, 20);

    _test.endTest();
}
