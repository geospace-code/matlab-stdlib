classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}) ...
    BenchmarkDevice < matlab.perftest.TestCase

properties
exist = "."
not_exist = tempname()
fun = @stdlib.device
end

properties(TestParameter)
backend
end

methods (TestParameterDefinition, Static)
function backend = setupBackend()
  backend = init_backend('device');
end
end


methods (Test)

function bench_exist(tc, backend)
tc.startMeasuring()
i = tc.fun(tc.exist, backend);
tc.stopMeasuring()

tc.verifyClass(i, 'uint64')
tc.assertNotEmpty(i)
tc.verifyGreaterThan(i, 0)
end


function bench_not_exist(tc, backend)
tc.startMeasuring()
i = tc.fun(tc.not_exist, backend);
tc.stopMeasuring()

tc.verifyClass(i, 'uint64')
tc.verifyEmpty(i)
end

end

end
