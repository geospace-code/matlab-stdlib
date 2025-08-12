classdef TestHDF4 < matlab.unittest.TestCase

properties
file
end

methods (TestClassSetup)
function setup_file(tc)
import matlab.unittest.constraints.IsFile
tc.file = fullfile(matlabroot, "toolbox/matlab/demos/example.hdf");
tc.assumeThat(tc.file, IsFile)

pkg_path(tc)
end
end

methods (Test, TestTags=["R2019b", "hdf4"])

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
