classdef (TestTags = {'R2019b', 'impure'}) ...
    TestIni < matlab.unittest.TestCase

methods(TestClassSetup)
function test_dirs(tc)
  pkg_path(tc)
end
end


methods (Test)

function test_example(tc)
import matlab.unittest.constraints.IsFile

cwd = fileparts(mfilename('fullpath'));
example = cwd + "/example.ini";

tc.assertThat(example, IsFile)

s = stdlib.ini2struct(example);
tc.verifyClass(s, 'struct')
tc.verifyEqual(s.DATA.keyNum, 113);

end

end

end
