classdef TestIni < matlab.unittest.TestCase

methods (Test)

function test_example(tc)
import matlab.unittest.constraints.IsFile
import stdlib.fileio.ini2struct

cwd = fileparts(mfilename('fullpath'));
example = fullfile(cwd, "+fileio", "example.ini");

tc.assumeThat(example, IsFile)

s = ini2struct(example);
tc.verifyClass(s, 'struct')
tc.verifyEqual(s.DATA.keyNum, 113);

end

end

end
