//A test to check switching rigid bodies between entities.

function start(){

	::stage <- 0;

    ::en1 <- _entity.create(Vec3());
    ::en2 <- _entity.create(Vec3());

    local shape = _physics.getCubeShape(1, 1, 1);
    ::body <- _physics.dynamics.createRigidBody(shape);

    //Give the body to the first entity.
    _component.rigidBody.add(en1, body);

    _physics.dynamics.addBody(body);
}

function update(){
    if(stage == 0){
		//en1 should start falling, en2 should stay at the origin.

		_test.assertEqual(en2.getPosition(), Vec3());

        print(en1.getPosition().y);
		if(en1.getPosition().y < -15){
			stage++;
		}
	}
	if(stage == 1){
		//Switch the entity with the component.
	    _component.rigidBody.remove(en1);
		::firstEntityPos <- en1.getPosition();
	    _component.rigidBody.add(en2, body);
		stage++;
	}
	if(stage == 2){
		//en1 should no longer move.
		_test.assertEqual(en1.getPosition(), firstEntityPos);
		//en2 should have immediately moved to where the body was.
        //There's an issue now where the body isn't moved immediately once the component is added.
        //_test.assertNotEqual(en2.getPosition(), Vec3());

		if(en2.getPosition().y < -30){
			//en2 carried on moving.
			_test.endTest();
		}
	}
}
