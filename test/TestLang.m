classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}) ...
    TestLang < matlab.unittest.TestCase


methods (Test, TestTags = {'R2022a', 'python'})

function test_has_python(tc)
tc.assumeTrue(stdlib.has_python(), 'Skipping test because Python is not available')
v = stdlib.python.version();
tc.verifyGreaterThanOrEqual(v, [3, 8, 0], 'expected Python >= 3.8')
end

function test_python_home(tc)
tc.assumeTrue(stdlib.has_python(), 'Skipping test because Python is not available')
r = stdlib.python.home();
tc.verifyClass(r, 'string')
tc.verifyThat(r, matlab.unittest.constraints.IsFolder, 'Python home folder does not exist')
end
end


methods (Test, TestTags = {'R2022b', 'dotnet'})

function test_dotnet_home(tc)
tc.assumeTrue(stdlib.has_dotnet(), 'Skipping test because .NET is not available')
h = stdlib.dotnet.home();
tc.verifyClass(h, 'string')
tc.verifyThat(h, matlab.unittest.constraints.IsFolder, '.NET home folder does not exist')
end


function test_dotnet_version(tc)
tc.assumeTrue(stdlib.has_dotnet(), 'Skipping test because .NET is not available')
v = stdlib.dotnet.version();

tc.verifyClass(v, 'char')
tc.verifyTrue(stdlib.version_atleast(v, '4.0'), '.NET version should be greater than 4.0')
end

end

end
