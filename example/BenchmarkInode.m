classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}) ...
    BenchmarkInode < matlab.perftest.TestCase

properties
exist = mfilename('fullpath') + ".m"
not_exist = tempname()
fun = @stdlib.inode
end

properties(TestParameter)
backend
end

methods (TestParameterDefinition, Static)
function backend = setupBackend()
  backend = init_backend('inode');
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
