classdef TestSys < matlab.unittest.TestCase

methods (TestClassSetup)
function setup_path(tc)
top = fullfile(fileparts(mfilename("fullpath")), "..");
tc.applyFixture(matlab.unittest.fixtures.PathFixture(top))
end
end

methods (Test)

function test_platform(tc)
import matlab.unittest.constraints.IsOfClass

tc.verifyThat(stdlib.iscygwin, IsOfClass('logical'))
tc.verifyThat(stdlib.isoctave, IsOfClass('logical'))

tc.verifyThat(stdlib.is_wsl, IsOfClass('logical'))

tc.verifyThat(stdlib.is_rosetta, IsOfClass('logical'))

tc.verifyThat(stdlib.isinteractive, IsOfClass('logical'))
end

end
end
