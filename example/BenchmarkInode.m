classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture("..")}) ...
    BenchmarkInode < matlab.perftest.TestCase

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
file = mfilename('fullpath') + ".m";
tc.startMeasuring()
i = stdlib.inode(file, backend);
tc.stopMeasuring()

tc.verifyClass(i, 'uint64')
tc.assertNotEmpty(i)
tc.verifyGreaterThan(i, 0)
end


function bench_not_exist(tc, backend)
file = tempname();
tc.startMeasuring()
i = stdlib.inode(file, backend);
tc.stopMeasuring()

tc.verifyClass(i, 'uint64')
tc.verifyEmpty(i)
end

end

end