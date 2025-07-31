classdef TestLang < matlab.unittest.TestCase

methods (TestClassSetup)
function pkg_path(tc)
  p = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
  tc.applyFixture(p)
end
end

methods (Test, TestTags = "python")

function test_python_home(tc)
tc.assumeTrue(stdlib.has_python(), "Python not available")
tc.verifyNotEmpty(stdlib.python_home())
end

end

end
