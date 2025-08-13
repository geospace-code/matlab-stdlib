classdef (TestTags = {'R2019b'}) ...
    TestLang < matlab.unittest.TestCase

methods (TestClassSetup)
function test_dirs(tc)
  pkg_path(tc)
end
end

methods (Test, TestTags = {'python'})

function test_has_python(tc)
tc.assumeTrue(stdlib.has_python())
v = stdlib.python_version();
tc.verifyTrue(all(v >= [3, 8, 0]), "expected Python >= 3.8")
end

function test_python_home(tc)
tc.assumeTrue(stdlib.has_python(), "Python not available")
tc.verifyNotEmpty(stdlib.python_home())
end

end


methods (Test, TestTags = {'dotnet'})

function test_dotnet_home(tc)
tc.assumeTrue(stdlib.has_dotnet(), ".NET not available")
tc.verifyNotEmpty(stdlib.dotnet_home())
end

function test_dotnet_version(tc)
tc.assumeTrue(stdlib.has_dotnet())
v = stdlib.dotnet_version();
tc.verifyTrue(stdlib.version_atleast(v, "4.0"), ".NET version should be greater than 4.0")
end

end

end
