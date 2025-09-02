classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}) ...
    BenchmarkGetOwner < matlab.perftest.TestCase

properties
exist = '.'
not_exist = tempname()
fun = @stdlib.get_owner
end

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
o = tc.fun(tc.exist, backend);
tc.stopMeasuring()

tc.verifyClass(o, 'string')
tc.verifyGreaterThan(strlength(o), 0)
end


function bench_not_exist(tc, backend)
tc.startMeasuring()
o = tc.fun(tc.not_exist, backend);
tc.stopMeasuring()

tc.verifyClass(o, 'string')
tc.verifyEqual(strlength(o), 0)
end

end

end
