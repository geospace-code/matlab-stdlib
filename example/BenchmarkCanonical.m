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
while(tc.keepMeasuring)
  o = fun(tc.exist, true);
end

tc.verifyClass(o, 'string')
tc.verifyGreaterThan(strlength(o), 0)
end


function bench_exist_main(tc)
while(tc.keepMeasuring)
  o = stdlib.canonical(tc.exist, true);
end

tc.verifyClass(o, 'string')
tc.verifyGreaterThan(strlength(o), 0)
end


function bench_not_exist(tc, fun)
while(tc.keepMeasuring)
  o = fun(tc.not_exist, true);
end

tc.verifyClass(o, 'string')
tc.verifyEqual(strlength(o), 0)
end

end

end
