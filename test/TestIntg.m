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
pe = pyenv;
tc.assumeFalse(pe.Version == "", "Python not available")
tc.assertTrue(islogical(stdlib.sys.checkRAM(1)))
end

function test_diskfree(tc)
tc.assumeTrue(usejava("jvm"), "Java required")

tc.assertTrue(isnumeric(stdlib.sys.diskfree('/')))
tc.assertTrue(stdlib.sys.diskfree('/') > 0, 'diskfree')
end

function test_memory(tc)
pe = pyenv;
tc.assumeFalse(pe.Version == "", "Python not available")
tc.assertTrue(isnumeric(stdlib.sys.memfree))
end

end
end