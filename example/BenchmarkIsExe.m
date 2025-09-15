classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}) ...
    BenchmarkIsExe < matlab.perftest.TestCase

properties
exist = fullfile(matlabroot, 'bin/matlab')
end

properties (TestParameter)
fun = {@stdlib.is_exe, @stdlib.native.is_exe, @stdlib.legacy.is_exe, @javafun.is_exe, @python.is_exe}
end

methods (Test)

function bench_exist(tc, fun)
e = tc.exist;
if ispc()
  e = e + ".exe";
end

while tc.keepMeasuring()
  y = fun(e);
end

tc.verifyEqual(y, true)
end


end

end
