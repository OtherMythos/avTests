//A test which checks XML files can be parsed as expected.

function start(){

    local doc = XMLDocument();
    doc.loadFile("res://res/fullXML.xml");

    local root = doc.getRootElement();
    local name = root.getName();
    _test.assertEqual(root.getName(), "scene");

    local child = root.getFirstChildElement();
    _test.assertEqual(child.getName(), "node");

    local attribs = [
        "first",
        "second",
        "third",
        "fourth"
    ];
    local attribsSecond = [
        "firstMesh",
        "secondMesh",
        "thirdMesh",
        "fourthMesh"
    ];
    local currentNode = child.getFirstChildElement();
    local i = 0;
    while(currentNode != null){
        local currentName = currentNode.getName();
        _test.assertEqual(currentName, "mesh");

        local attrib = currentNode.getAttribute("name");
        _test.assertEqual(attrib, attribs[i]);

        attrib = currentNode.getAttribute("mesh");
        _test.assertEqual(attrib, attribsSecond[i]);

        attrib = currentNode.getAttribute("invalid");
        _test.assertEqual(attrib, null);

        parseEntry(currentNode);

        currentNode = currentNode.nextSiblingElement();
        i++;
    }

    _test.endTest();
}

function parseEntry(parent){
    local firstVal = parent.getFirstChildElement();
    local currentName = firstVal.getName();
    _test.assertEqual(currentName, "position");

    local secondVal = firstVal.nextSiblingElement();
    currentName = secondVal.getName();
    _test.assertEqual(currentName, "scale");
}