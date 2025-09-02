classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}) ...
    BenchmarkSamepath < matlab.perftest.TestCase

properties
exist = [".", pwd()]
diff = [".", mfilename('fullpath') + ".m"]
not = tempname()
fun = @stdlib.samepath
end

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
y = tc.fun(tc.exist(1), tc.exist(2), backend);
tc.stopMeasuring()

tc.verifyEqual(y, true)
end


function bench_diff(tc, backend)
tc.startMeasuring()
y = tc.fun(tc.diff(1), tc.diff(2), backend);
tc.stopMeasuring()

tc.verifyEqual(y, false)
end


function bench_not_exist(tc, backend)
tc.startMeasuring()
y = tc.fun(tc.not, tc.not, backend);
tc.stopMeasuring()

tc.verifyEqual(y, false)
end

end

end
