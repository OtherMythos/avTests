//A test to check that entities can have their lifetime reduction paused.

function start(){
    _world.createWorld();

    ::en <- _entity.create(SlotPosition());
    ::en2 <- _entity.create(SlotPosition());
    _component.lifetime.add(::en, 100);
    _component.lifetime.add(::en2, 100);

    ::count <- 0;
}

function update(){
    ::count++;

    if(count == 50){
        //Check the lifetime stops being applied when it's removed.
        _state.setPauseState(_PAUSE_LIFETIME_COMPONENT);
    }
    if(count <= 130){
        _test.assertTrue(::en.valid());
    }

    if(count == 100){
        _state.setPauseState(0);
    }

    //If it didn't become invalid before the test timeout then the lifetime didn't work, otherwise pass the test.
    if(!::en2.valid()){
        _test.endTest();
    }
}
