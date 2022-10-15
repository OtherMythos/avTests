//A test to check audio setup and the audio namespace.

function start(){
    local source = _audio.newSource("res://../../../Resources/Sounds/audioBite.wav");
    source.play();

    local audioBuf = source.getAudioBuffer();
    print(audioBuf);

    local posVal = Vec3(0.1, 0.2, 0.3);
    _audio.setListenerPosition(posVal);
    _test.assertEqual(posVal, _audio.getListenerPosition());

    _audio.setVolume(0.5);
    _test.assertEqual(_audio.getVolume(), 0.5);

    local velVal = Vec3(0.2, 0.3, 0.4);
    _audio.setListenerVelocity(velVal);
    _test.assertEqual(_audio.getListenerVelocity(), velVal);
}

function update(){

}
