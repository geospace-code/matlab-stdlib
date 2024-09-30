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

tc.assumeTrue(stdlib.has_java)
tc.assertTrue(islogical(stdlib.checkRAM(1)))
end

function test_diskfree(tc)

tc.assumeTrue(stdlib.has_java)
tc.assertTrue(isnumeric(stdlib.diskfree('/')))
tc.assertTrue(stdlib.diskfree('/') > 0, 'diskfree')
end


end
end
