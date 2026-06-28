classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}) ...
    TestLang < matlab.unittest.TestCase


methods (Test, TestTags = {'R2020b', 'python'})

function test_has_python(tc)
tc.assumeTrue(stdlib.has_python())
v = stdlib.python.version();
tc.verifyTrue(all(v >= [3, 8, 0]), 'expected Python >= 3.8')
end

function test_python_home(tc)
tc.assumeTrue(stdlib.has_python(), 'Python not available')

r = stdlib.python.home();
tc.verifyClass(r, 'string')
end

end


methods (Test, TestTags = {'R2022b', 'dotnet'})

function test_dotnet_home(tc)
tc.assumeTrue(stdlib.has_dotnet(), '.NET not available')
h = stdlib.dotnet.home();

tc.verifyGreaterThan(strlength(h), 0)
end


function test_dotnet_version(tc)
v = stdlib.dotnet.version();

if stdlib.has_dotnet()
  tc.verifyClass(v, 'char')
  tc.verifyTrue(stdlib.version_atleast(v, '4.0'), '.NET version should be greater than 4.0')
else
  tc.verifyEqual(v, missing)
end
end

end

end
