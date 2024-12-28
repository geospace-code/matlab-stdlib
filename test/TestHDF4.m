classdef TestHDF4 < matlab.unittest.TestCase

properties
TestData
end

methods (TestClassSetup)
function setup_file(tc)
import matlab.unittest.constraints.IsFile
tc.TestData.basic = fullfile(matlabroot, "toolbox/matlab/demos/example.hdf");
tc.assumeThat(tc.TestData.basic, IsFile)
end
end

methods (Test)

function test_exists(tc)
import matlab.unittest.constraints.IsScalar
basic = tc.TestData.basic;

e = stdlib.h4exists(basic, "Example SDS");

tc.verifyThat(e, IsScalar)
tc.verifyTrue(e);

tc.verifyFalse(stdlib.h4exists(basic, "/j"))

end


function test_size(tc)
basic = tc.TestData.basic;

s = stdlib.h4size(basic, "Example SDS");
tc.verifyEqual(s, [16, 5])

end


function test_vars(tc)
basic = tc.TestData.basic;

v = stdlib.h4variables(basic);
tc.verifyTrue(any(contains(v, "Example SDS")))
end


end
end
