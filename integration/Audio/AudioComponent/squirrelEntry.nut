//A test to check that audio components can be added to entities.

function start(){
    //Setup the world to create entities.
    _world.createWorld();

    local source = _audio.newSource("res://../../../Resources/Sounds/audioBite.wav");
    source.play();

    ::e <- _entity.create(SlotPosition());

    _component.audio.add(e, source);

    ::entityPosition <- Vec3(1, 0, 0);

}

function update(){
    ::entityPosition.x += 0.05;
    ::e.setPosition(SlotPosition(::entityPosition));

    print(entityPosition);
    local audioSource = _component.audio.get(e, 0);
    _test.assertEqual(::entityPosition, audioSource.getPosition());
}
