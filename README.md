A set of integration tests for the avEngine.

These tests can be run by starting the engine and passing it an argument containing the path to an avSetup.cfg file.

```shell
./av ~/Documents/avTests/integration/SlotManagerTests/SlotManagerActivatesChunk/avSetup.cfg
```

As well as console output, This will produce a file named avTestFile.txt, which contains the results of the test. It is intended to be parsed by the test runner in the avTools repository.
