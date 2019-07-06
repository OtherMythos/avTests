function stationary(currentPos){
    if( !("stationaryPreviousPos" in getroottable()) ) ::stationaryPreviousPos <- SlotPosition();
    if( !("stationaryPreviousCount" in getroottable()) ) ::stationaryPreviousCount <- 0;

    if(currentPos.y < -50){
        //The shape fell through the shape chunk, so fail.
        _test.endTest(false);
    }

    if(stationaryPreviousPos.equals(currentPos)){
        stationaryPreviousCount++;
    }else{
        stationaryPreviousCount = 0;
    }

    if(stationaryPreviousCount >= 10){
        //The shape has stayed still for 10 frames, so it is resting on the body on the ground.
        stationaryPreviousCount = 0;
        return true;
    }

    stationaryPreviousPos = currentPos;

    return false;
}
