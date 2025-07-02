classdef TestIsExe < matlab.unittest.TestCase

properties (TestParameter)
p = {{"", false}, {tempname(), false}, {".", true}}
end

methods(Test, TestTags="impure")
function test_is_exe(tc, p)
tc.verifyEqual(stdlib.is_exe(p{1}), p{2})
end

function test_matlabroot(tc)

f = fullfile(matlabroot, "bin", "matlab");
if ispc()
  f = f + ".exe";
end

tc.verifyEqual(stdlib.is_exe(f), true)
end

end
end
