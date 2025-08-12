classdef TestLang < matlab.unittest.TestCase

methods (TestClassSetup)
function test_dirs(tc)
  pkg_path(tc)
end
end

methods (Test, TestTags = ["R2019b", "python"])

function test_python_home(tc)
tc.assumeTrue(stdlib.has_python(), "Python not available")
tc.verifyNotEmpty(stdlib.python_home())
end

end

end
