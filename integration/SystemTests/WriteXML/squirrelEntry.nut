//A test which builds an XML document from scratch and writes it to a file.

function start(){

    local doc = XMLDocument();
    local root = doc.newElement("root");

    local first = root.insertNewChildElement("child");

    _system.ensureUserDirectory();

    doc.writeFile("user://test.xml");

    //Check it can be parsed the other end.
    local docBackIn = XMLDocument();
    docBackIn.loadFile("user://test.xml");

    local root = docBackIn.getRootElement();
    _test.assertEqual(root.getName(), "root");

    _test.endTest();
}