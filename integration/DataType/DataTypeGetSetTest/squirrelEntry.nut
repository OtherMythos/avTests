//A test which checks proper error checking is performed on data types.

function start(){

    local tests = [
        //Vec3
        function(){
            local vec = Vec3();
            //Incorrect value setter name
            vec.thing = 10;
        },
        function(){
            local vec = Vec3();
            //Incorrect value getter name
            local val = vec.thing;
        },
        function(){
            local vec = Vec3();
            //Query with a value that isn't a string key.
            local val = vec[0];
        },

        //Vec2
        function(){
            local vec = Vec2();
            //Incorrect value setter name
            vec.thing = 10;
        },
        function(){
            local vec = Vec2();
            //Incorrect value getter name
            local val = vec.thing;
        },
        function(){
            local vec = Vec2();
            //Query with a value that isn't a string key.
            local val = vec[0];
        },

        //Quaternion
        function(){
            local vec = Quaternion();
            //Incorrect value setter name
            vec.thing = 10;
        },
        function(){
            local vec = Quaternion();
            //Incorrect value getter name
            local val = vec.thing;
        },
        function(){
            local vec = Quaternion();
            //Query with a value that isn't a string key.
            local val = vec[0];
        },

        //SlotPosition
        function(){
            local vec = SlotPosition();
            //Incorrect value setter name
            vec.thing = 10;
        },
        function(){
            local vec = SlotPosition();
            //Incorrect value getter name
            local val = vec.thing;
        },
        function(){
            local vec = SlotPosition();
            //Query with a value that isn't a string key.
            local val = vec[0];
        },
    ];

    //Execute the tests
    foreach(i in tests){
        local failed = false;
        try{
            i();
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
    }


    _test.endTest();
}
