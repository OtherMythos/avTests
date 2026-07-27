//A test which checks custom user settings appear in the setup file.

function start(){


    ::startPos <- Vec3();
    ::destination <- Vec3(30,0,40);
    ::mesh <- _mesh.create("cube");

    ::e <- _entity.create(Vec3());

    _camera.setPosition(0, 50, 100);
    _camera.lookAt(0, 0, 0);
}

function update(){
    ::startPos.moveTowards(::destination, 1);
    ::e.moveTowards(::destination, 1);

    ::mesh.setPosition(startPos);
    _test.assertEqual(::startPos, ::e.getPosition());
    print(startPos);
    if(startPos.equals(destination)){
        _test.endTest();
    }
}
