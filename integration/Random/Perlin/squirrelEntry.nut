//A test to check perlin noise can be generated from the random namespace.

const PANEL_SIZE = 10;

function positionPanel(x, y, value){
    local name = format("perlinMaterial%i-%i", x, y);
    local unlitBlock = _hlms.unlit.createDatablock(name);
    unlitBlock.setColour(value, value, value, 1.0);

    local newRec = Rect2d();
    newRec.setDatablock(unlitBlock);
    newRec.setPosition(x * PANEL_SIZE, y * PANEL_SIZE);
    newRec.setSize(PANEL_SIZE, PANEL_SIZE);
    panels.append(newRec);
}

function start(){
    _random.seedPatternGenerator(150);

    ::panels <- [];
    local width = 100;
    local height = 100;
    local noise = _random.genPerlinNoise(width, height, 0.1, 4);

    for(local y = 0; y < height; y++){
        for(local x = 0; x < width; x++){
            local floatVal = noise.readn('f');
            positionPanel(x, y, floatVal);

            if(y == 50 && x == 50){
                //Check this value is always the same, as the value is seeded.
                //Have to turn it into an integer to make the comparison work.
                _test.assertEqual((floatVal * 100000).tointeger(), 33750);
            }
        }
    }
}
