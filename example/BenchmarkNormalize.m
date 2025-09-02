classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}) ...
    BenchmarkNormalize < matlab.perftest.TestCase

properties
P = './a/././//'
end

properties(TestParameter)
backend
end

methods (TestParameterDefinition, Static)
function backend = setupBackend()
  backend = init_backend('normalize');
end
end

methods (Test)

function bench(tc, backend)
tc.startMeasuring()
o = stdlib.normalize(tc.P, backend);
tc.stopMeasuring()

tc.verifyClass(o, 'string')
tc.verifyGreaterThan(strlength(o), 0)
end


end

end
