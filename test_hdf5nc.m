% unit test
suite = matlab.unittest.TestSuite.fromPackage('hdf5nc.tests');
run(suite);
