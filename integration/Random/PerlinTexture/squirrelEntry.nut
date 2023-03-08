//A test to check perlin noise can be baked into a texture by the engine.

function start(){
    local width = 200;
    local height = 200;
    local noise = _graphics.genPerlinNoiseTexture("perlinNoiseTexture", width, height);

    local datablock = _hlms.unlit.createDatablock("perlinDatablock");
    datablock.setTexture(0, noise);

    ::mesh <- _mesh.create("plane");
    mesh.setDatablock(datablock);

    _camera.setPosition(0, 0, 10);
    _camera.lookAt(0, 0, 0);
    _camera.setProjectionType(_PT_ORTHOGRAPHIC);
    _camera.setOrthoWindow(2, 2);
}
