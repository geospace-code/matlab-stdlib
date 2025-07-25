classdef TestIsExe < matlab.unittest.TestCase

properties (TestParameter)
p = {{fileparts(mfilename('fullpath')) + "/../Readme.md", false}, {"not-exist", false}}
end

methods(Test, TestTags="impure")

function test_is_exe(tc, p)
tc.verifyEqual(stdlib.is_exe(p{1}), p{2})
end


function test_is_exe_dir(tc)
tc.verifyFalse(stdlib.is_exe('.'))
end


function test_matlab_exe(tc)

f = fullfile(matlabroot, "bin/matlab");
if ispc()
  f = f + ".exe";
end

tc.verifyTrue(stdlib.is_exe(f))
end

end
end
