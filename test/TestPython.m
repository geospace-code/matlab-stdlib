classdef TestPython < matlab.unittest.TestCase

methods (TestClassSetup)
function check_python_available(tc)
tc.assumeTrue(stdlib.has_python(), "Python is not available, skipping tests")
end

function pkg_path(tc)
p = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(p)
end
end


methods (Test, TestTags = "python")

function test_is_char_device(tc)
% /dev/stdin may not be available on CI systems
if ispc
  n = "NUL";
else
  n = "/dev/null";
end

tc.verifyTrue(stdlib.is_char_device(n))
end

end

end
