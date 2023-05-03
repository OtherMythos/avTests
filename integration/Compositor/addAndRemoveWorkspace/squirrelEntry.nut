//A test to check that compositor workspaces can be added and remove correctly.

function start(){

    local camera = _scene.createCamera("first");
    _scene.getRootSceneNode().createChildSceneNode().attachObject(camera);

    local renderTexture = _window.getRenderTexture();

    local targetWorkspaces = [
        "workspaceFirst",
        "workspaceSecond",
        "workspaceThird"
    ];

    local createdWorkspaces = [];
    foreach(i in targetWorkspaces){
        local newWorkspace = _compositor.addWorkspace([renderTexture], camera, i, false);
        createdWorkspaces.append(newWorkspace);
        _test.assertTrue(newWorkspace.isValid());
    }

    createdWorkspaces[0].setEnabled(true);

    ::stage <- 0;
    ::stageCount <- 0;

    _test.endTest();
}

function update(){
    if(stage == 0){
        stageCount++;
        if(stageCount >= 20){
            stageCount = 0;
            stage++;

            foreach(i in createdWorkspaces){
                _compositor.removeWorkspace(i);
                _test.assertFalse(newWorkspace.isValid());

                local failed = false;
                try{
                    //Should fail as the workspace is invalid now.
                    i.setEnabled(false);
                }catch(e){
                    failed = true;
                }
            }
        }
    }
    else if(stage == 1){
        stageCount++;
        if(stageCount >= 20){
            _test.endTest();
        }
    }
}
