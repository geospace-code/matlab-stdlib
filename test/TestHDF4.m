classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2017a', 'hdf4'}) ...
    TestHDF4 < matlab.unittest.TestCase

properties
file = fullfile(matlabroot, 'toolbox/matlab/demos/example.hdf')
end

methods (TestClassSetup)
function check_file(tc)
tc.assumeTrue(stdlib.is_file(tc.file), 'HDF4 file not found:')
end
end

methods (Test)

function test_exists(tc)

e = stdlib.h4exists(tc.file, 'Example SDS');

tc.verifyThat(e, matlab.unittest.constraints.IsScalar)
tc.verifyTrue(e);

tc.verifyFalse(stdlib.h4exists(tc.file, '/j'))
end


function test_size(tc)
s = stdlib.h4size(tc.file, 'Example SDS');
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
