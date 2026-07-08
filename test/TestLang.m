classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}) ...
    TestLang < matlab.unittest.TestCase


methods (Test, TestTags = {'R2022a', 'python'})

function test_has_python(tc)
v = stdlib.python.version();
if stdlib.has_python()
  tc.verifyGreaterThanOrEqual(v, [3, 8, 0], 'expected Python >= 3.8')
else
  tc.verifyEqual(v, missing)
end
end

function test_python_home(tc)
r = stdlib.python_home();
if stdlib.has_python()
  tc.verifyClass(r, 'string')
  tc.verifyThat(r, matlab.unittest.constraints.IsFolder, 'Python home folder does not exist')
else
  tc.verifyEqual(r, missing)
end
end
end


methods (Test, TestTags = {'R2022b', 'dotnet'})

function test_dotnet_home(tc)
h = stdlib.dotnet.home();
if stdlib.has_dotnet()
  tc.verifyClass(h, 'string')
  tc.verifyThat(h, matlab.unittest.constraints.IsFolder, '.NET home folder does not exist')
else
  tc.verifyEqual(h, missing)
end
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
