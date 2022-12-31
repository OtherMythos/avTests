//Checks objects can have their transparency altered.

function start(){
    ::stage <- 0;
    ::count <- 0.0;
    ::mesh <- _mesh.create("ogrehead2.mesh");
    mesh.setScale(0.1, 0.1, 0.1);
    _camera.setPosition(0, 0, 30);
    _camera.lookAt(0, 0, 0);

    ::datablock <- _hlms.pbs.createDatablock("someDatablockName");
    datablock.setTransparency(0.0);
    ::mesh.setDatablock(::datablock);

    local failed = false;
    try{
        //Test invalid mode
        datablock.setTransparency(count, 100);
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);
}

function update(){
    count += 0.01;
    print(count);
    if(count >= 1.0){
        count = 0;
        stage++;
    }

    if(stage == 0){
        datablock.setTransparency(count);
    }
    else if(stage == 1){
        //Try the different modes.
        datablock.setTransparency(count, _PBS_TRANSPARENCY_FADE);
    }
    else if(stage == 2){
        //TODO Needs some compositor work.
        //datablock.setTransparency(count, _PBS_TRANSPARENCY_REFRACTIVE);
    }
}
