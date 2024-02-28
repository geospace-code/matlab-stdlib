classdef TestVersion < matlab.unittest.TestCase

methods (TestClassSetup)
function setup_path(tc)
import matlab.unittest.fixtures.PathFixture
cwd = fileparts(mfilename("fullpath"));
top = fullfile(cwd, "..");
tc.applyFixture(PathFixture(top))
end
end

methods (Test)

function test_version(tc)
tc.verifyTrue(stdlib.version_atleast("3.19.0.33", "3.19.0"))
tc.verifyFalse(stdlib.version_atleast("3.19.0.33", "3.19.0.34"))
end

end

end
