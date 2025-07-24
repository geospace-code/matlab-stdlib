classdef TestIsExe < matlab.unittest.TestCase

properties (TestParameter)
p = {{".", false}}
end

methods(Test, TestTags="impure")
function test_is_exe(tc, p)
tc.verifyEqual(stdlib.is_exe(p{1}), p{2})
end

function test_matlab_exe(tc)

f = fullfile(matlabroot, "bin/matlab");
if ispc()
  f = f + ".exe";
end

tc.verifyEqual(stdlib.is_exe(f), true)
end

end
end
