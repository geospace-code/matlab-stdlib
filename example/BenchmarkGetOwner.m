classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture("..")}) ...
    BenchmarkGetOwner < matlab.perftest.TestCase

properties(TestParameter)
backend
end

methods (TestParameterDefinition, Static)
function backend = setupBackend()
  backend = init_backend('get_owner');
end
end


methods (Test)

function bench_exist(tc, backend)
tc.startMeasuring()
o = stdlib.get_owner('.', backend);
tc.stopMeasuring()

tc.verifyClass(o, 'string')
tc.verifyGreaterThan(strlength(o), 0)
end


function bench_not_exist(tc, backend)
tc.startMeasuring()
o = stdlib.get_owner('not-exist', backend);
tc.stopMeasuring()

tc.verifyClass(o, 'string')
tc.verifyEqual(strlength(o), 0)
end

end

end