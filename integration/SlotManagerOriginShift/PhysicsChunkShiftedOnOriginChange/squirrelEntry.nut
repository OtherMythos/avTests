//A test to check that physics chunks are shifted when an origin change happens.

function start(){
    dofile(_settings.getDataDirectory() + "/../../../Resources/scripts/physicsScripts.nut");

    _world.createWorld();
    _world.setPlayerLoadRadius(1);
    _slotManager.setCurrentMap("physicsTestMap");

    _camera.setPosition(0, 0, 200);
    _camera.lookAt(0, 0, 0);

	::entity <- _entity.create(SlotPosition());
	::previousPos <- entity.getPosition();
	::previousCount <- 0;
    ::stage <- 0;

    ::constructionInfo <- {"mass": 1, "origin": [0, 20, 0]};
    ::shape <- _physics.getCubeShape(1, 1, 1);
    ::body <- _physics.dynamics.createRigidBody(shape, constructionInfo);
    _physics.dynamics.addBody(body);
    _component.rigidBody.add(entity, body);
    _component.mesh.add(entity, "ogrehead2.mesh");
}

function update(){
	local enPos = entity.getPosition();
    if(stage == 0){
        if(stationary(enPos)){
            stage++;
        }
    }
    if(stage == 1){
        _slotManager.setOrigin(SlotPosition(0, 0, 20, 0, 20));
        entity.setPosition(SlotPosition(0, 0, 0, 50, 0));

        stage++;
    }
    if(stage == 2){
        if(stationary(enPos)){
            _test.endTest();
        }
    }

}
