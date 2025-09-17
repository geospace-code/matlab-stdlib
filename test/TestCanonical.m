classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2017a'}) ...
  TestCanonical < matlab.unittest.TestCase

properties (TestParameter)
p = {{'', ''}, ...
{"", ""}, ...
{"not-exist", "not-exist"}, ...
{'a/../b', 'a/../b'}, ...
{"not-exist/a/..", "not-exist/a/.."}, ...
{"./not-exist", "not-exist"}
};
end

methods (TestClassSetup)
function test_dirs(tc)
tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture());
end
end


methods (Test)
function test_canonical(tc, p)
c = stdlib.canonical(p{1}, false);
tc.verifyEqual(c, p{2})
end

function test_canonical_cwd(tc)
c = stdlib.canonical('.', true);
tc.verifyEqual(c, pwd())
end

end

end
