classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}) ...
    BenchmarkRelativeTo < matlab.perftest.TestCase

properties
in = [pwd(), pwd() + "/a"]
ref = "a"
end

properties (TestParameter)
fun = {@stdlib.relative_to, @stdlib.python.relative_to}
end


methods (Test)

function bench_main(tc, fun)
while tc.keepMeasuring()
  r = fun(tc.in(1), tc.in(2));
end

tc.verifyEqual(r, tc.ref)
end

end

end
