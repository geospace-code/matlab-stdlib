classdef TestIni < matlab.unittest.TestCase


methods (Test)

function test_example(tc)
import matlab.unittest.constraints.IsFile

cwd = fileparts(mfilename('fullpath'));
example = cwd + "/example.ini";

tc.assumeThat(example, IsFile)

s = stdlib.ini2struct(example);
tc.verifyClass(s, 'struct')
tc.verifyEqual(s.DATA.keyNum, 113);

end

end

end
