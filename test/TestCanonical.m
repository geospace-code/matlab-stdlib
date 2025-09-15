classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'impure'}) ...
  TestCanonical < matlab.unittest.TestCase

properties (TestParameter)
p = {{'', ''}, ...
{"", ""}, ...
{"not-exist", "not-exist"}, ...
{"a/../b", "a/../b"}, ...
{append(mfilename("fullpath"), '.m/..'), fileparts(mfilename("fullpath"))}, ...
{"not-exist/a/..", "not-exist/a/.."}, ...
{"./not-exist", "not-exist"}
};
end

methods (TestClassSetup)
function test_dirs(tc)
tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture())
end
end


methods (Test, TestTags={'R2019b'})
function test_canonical(tc, p)
c = stdlib.canonical(p{1}, false);
tc.verifyEqual(c, p{2})
end

end

end
