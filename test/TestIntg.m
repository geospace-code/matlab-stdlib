classdef TestIntg < matlab.unittest.TestCase

methods (TestClassSetup)
function setup_path(tc)
import matlab.unittest.fixtures.PathFixture
cwd = fileparts(mfilename("fullpath"));
top = fullfile(cwd, "..");
tc.applyFixture(PathFixture(top))
end
end


methods (Test)

function test_checkRAM(tc)
tc.assertTrue(islogical(stdlib.sys.checkRAM(1)))
end

function test_diskfree(tc)

tc.assertTrue(isnumeric(stdlib.sys.diskfree('/')))
tc.assertTrue(stdlib.sys.diskfree('/') > 0, 'diskfree')
end


end
end
