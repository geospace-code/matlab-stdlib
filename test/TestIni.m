classdef TestIni < matlab.unittest.TestCase

methods (TestClassSetup)
function setup_path(tc)
import matlab.unittest.fixtures.PathFixture
cwd = fileparts(mfilename("fullpath"));
top = fullfile(cwd, "..");
tc.applyFixture(PathFixture(top))
end
end

methods (Test)

function test_example(tc)
import matlab.unittest.constraints.IsFile

cwd = fileparts(mfilename('fullpath'));
example = fullfile(cwd, "example.ini");

tc.assumeThat(example, IsFile)

s = stdlib.fileio.ini2struct(example);
tc.verifyClass(s, 'struct')
tc.verifyEqual(s.DATA.keyNum, 113);

end

end

end
