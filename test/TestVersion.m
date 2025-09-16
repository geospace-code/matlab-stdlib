classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2017b', 'pure'}) ...
    TestVersion < matlab.unittest.TestCase

properties (TestParameter)
v = {{"11.1", "9.3", true}, ...
    {"3.19.0.33", "3.19.0", true}, ...
    {"3.19.0.33", "3.19.0.34", false}, ...
    {"1.5.0.3", "1.5.0", true}, ...
    {"1.5.0", "1.5.0.3", false}
    }
end


methods (Test)

function test_version(tc, v)
tc.verifyEqual(stdlib.version_atleast(v{1}, v{2}), v{3})
end

end

end
