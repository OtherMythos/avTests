//A test to check that entities are destroyed when their lifetime is reached.

function start(){

    ::en <- _entity.create(Vec3());
    ::en2 <- _entity.create(Vec3());
    _component.lifetime.add(::en, 200);
    _component.lifetime.add(::en2, 200);

    ::count <- 0;
}

function update(){
    ::count++;

    if(count == 50){
        //Check the lifetime stops being applied when it's removed.
        _component.lifetime.remove(::en);
    }
    _test.assertTrue(::en.valid());
    //If it didn't become invalid before the test timeout then the lifetime didn't work, otherwise pass the test.
    if(!::en2.valid()){
        _test.endTest();
    }
}
