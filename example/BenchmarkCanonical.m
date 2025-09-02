classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}) ...
    BenchmarkCanonical < matlab.perftest.TestCase

properties
exist = '.'
not_exist = tempname()
end

properties(TestParameter)
fun = {@stdlib.native.canonical, @stdlib.legacy.canonical}
end


methods (Test)

function bench_exist(tc, fun)
tc.startMeasuring()
o = fun(tc.exist, true);
tc.stopMeasuring()

tc.verifyClass(o, 'string')
tc.verifyGreaterThan(strlength(o), 0)
end


function bench_not_exist(tc, fun)
tc.startMeasuring()
o = fun(tc.not_exist, true);
tc.stopMeasuring()

tc.verifyClass(o, 'string')
tc.verifyEqual(strlength(o), 0)
end

end

end
