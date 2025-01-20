classdef TestIsExe < matlab.unittest.TestCase

properties (TestParameter)
p = init_is_exe()
end

methods(Test)
function test_is_exe(tc, p)
tc.verifyEqual(stdlib.is_exe(p{1}), p{2})
end
end
end


function p = init_is_exe()

n = "matlab";

f = matlabroot + "/bin/" + n;
if ispc
  f = f + ".exe";
end


p = {{"", false}, {tempname, false}, {".", true}, {f, true}};
end
