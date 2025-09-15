classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2019a'}) ...
  TestCanonical < matlab.unittest.TestCase

properties (TestParameter)
p = {{'', ''}, ...
{"", ""}, ...
{"not-exist", "not-exist"}, ...
{'a/../b', 'a/../b'}, ...
{[mfilename("fullpath"), '.m/..'], fileparts(mfilename("fullpath"))}, ...
{"not-exist/a/..", "not-exist/a/.."}, ...
{"./not-exist", "not-exist"}
};
end

methods (TestClassSetup)
function test_dirs(tc)
tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture())
end
end


methods (Test)
function test_canonical(tc, p)
c = stdlib.canonical(p{1}, false);
tc.verifyEqual(c, p{2})
end

end

end
