//A test to check perlin noise can be baked into a texture by the engine.

function start(){
    local width = 200;
    local height = 200;

    local vals = [
        [0.05, 2],
        [0.5, 4],
        [1.0, 6]
    ];
    ::meshes <- [];
    foreach(c,i in vals){
        local noise = _graphics.genPerlinNoiseTexture("perlinNoiseTexture" + c, width, height, i[0], i[1]);

        local datablock = _hlms.unlit.createDatablock("perlinDatablock" + c);
        datablock.setTexture(0, noise);

        local mesh = _mesh.create("plane");
        mesh.setDatablock(datablock);
        ::meshes.append(mesh);
        local spacing = 0.2;
        mesh.setPosition(c * spacing*3 - (vals.len().tofloat()*spacing), 0, 0);
        mesh.setScale(spacing, spacing, spacing);
    }

    _camera.setPosition(0, 0, 10);
    _camera.lookAt(0, 0, 0);
    _camera.setProjectionType(_PT_ORTHOGRAPHIC);
    _camera.setOrthoWindow(2, 2);
}
