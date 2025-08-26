classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture("..")}) ...
    BenchmarkSamepath < matlab.perftest.TestCase

properties(TestParameter)
backend
end

methods (TestParameterDefinition, Static)
function backend = setupBackend()
  backend = init_backend('samepath');
end
end


methods (Test)

function bench_exist(tc, backend)
tc.startMeasuring()
y = stdlib.samepath('.', pwd(), backend);
tc.stopMeasuring()

tc.verifyEqual(y, true)
end


function bench_diff(tc, backend)
tc.startMeasuring()
y = stdlib.samepath('.', mfilename('fullpath'), backend);
tc.stopMeasuring()

tc.verifyEqual(y, false)
end


function bench_not_exist(tc, backend)
tc.startMeasuring()
y = stdlib.samepath('not-exist', 'not-exist', backend);
tc.stopMeasuring()

tc.verifyEqual(y, false)
end

end

end