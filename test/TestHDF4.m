classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2019b', 'hdf4'}) ...
    TestHDF4 < matlab.unittest.TestCase

properties
file
end

methods (TestClassSetup)
function setup_file(tc)
tc.file = fullfile(matlabroot, "toolbox/matlab/demos/example.hdf");
tc.assumeThat(tc.file, matlab.unittest.constraints.IsFile)
end
end

methods (Test)

function test_exists(tc)
import matlab.unittest.constraints.IsScalar

e = stdlib.h4exists(tc.file, "Example SDS");

tc.verifyThat(e, IsScalar)
tc.verifyTrue(e);

tc.verifyFalse(stdlib.h4exists(tc.file, "/j"))
end


function test_size(tc)
s = stdlib.h4size(tc.file, "Example SDS");
tc.verifyEqual(s, [16, 5])
end


function test_vars(tc)
import matlab.unittest.constraints.AnyElementOf
import matlab.unittest.constraints.IsEqualTo

v = stdlib.h4variables(tc.file);
tc.verifyThat(AnyElementOf(v), IsEqualTo("Example SDS"))
end


end
end
