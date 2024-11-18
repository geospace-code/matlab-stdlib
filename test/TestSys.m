classdef TestSys < matlab.unittest.TestCase

methods (TestClassSetup)
function setup_path(tc)
import matlab.unittest.fixtures.PathFixture
cwd = fileparts(mfilename("fullpath"));
top = fullfile(cwd, "..");
tc.applyFixture(PathFixture(top))
end
end

methods (Test)

function test_platform(tc)
import matlab.unittest.constraints.IsOfClass

tc.verifyThat(stdlib.iscygwin, IsOfClass('logical'))
tc.verifyThat(stdlib.isoctave, IsOfClass('logical'))

tc.verifyThat(stdlib.iswsl, IsOfClass('logical'))
tc.verifyThat(stdlib.has_wsl, IsOfClass('logical'))

tc.verifyThat(stdlib.is_rosetta, IsOfClass('logical'))

tc.verifyThat(stdlib.isinteractive, IsOfClass('logical'))

tc.verifyThat(stdlib.is_windows_powershell, IsOfClass('logical'))
end

end
end
