//A test to check audio buffers can be re-used and re-assigned.

function start(){
    local soundBuffer = _audio.newSoundBuffer();
    soundBuffer.load("res://../../../Resources/Sounds/audioBite.wav");

    {
        local audioSource = _audio.newSourceFromBuffer(soundBuffer);

        _test.assertEqual(_audio.getNumAudioSources(), 1);
        _test.assertEqual(_audio.getNumAudioBuffers(), 1);
    }
    //Just the source should be destroyed, but the buffer should still exist.

    _test.assertEqual(_audio.getNumAudioSources(), 0);

    {
        local audioSource = _audio.newSourceFromBuffer(soundBuffer);

        //Destroying the reference to the buffer, it should still exist as it is held by the source.
        soundBuffer = null;
        _test.assertEqual(_audio.getNumAudioSources(), 1);
        _test.assertEqual(_audio.getNumAudioBuffers(), 1);
    }

    //As the source has gone, the buffer should go as well.
    _test.assertEqual(_audio.getNumAudioSources(), 0);
    _test.assertEqual(_audio.getNumAudioBuffers(), 0);

    _test.endTest();
}

function update(){

}
