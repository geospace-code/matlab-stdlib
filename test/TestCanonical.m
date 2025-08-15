classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture("..")}, ...
          TestTags = {'R2019b', 'impure'}) ...
  TestCanonical < matlab.unittest.TestCase

properties(TestParameter)
p = {{'', ""}, ...
{"", ""}, ...
{"not-exist", "not-exist"}, ...
{"a/../b", "b"}, ...
{strcat(mfilename("fullpath"), '.m/..'), string(fileparts(mfilename("fullpath")))}, ...
{"not-exist/a/..", "not-exist"}, ...
{"./not-exist", "not-exist"}
};
end

methods(TestClassSetup)
function test_dirs(tc)
tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture())
end
end


methods(Test)

function test_canonical(tc, p)
c = stdlib.canonical(p{1}, false);
tc.verifyEqual(c, p{2})
end

function test_legacy_canonical(tc, p)
c = stdlib.legacy.canonical(p{1}, false);
tc.verifyEqual(c, p{2})
end


function test_canonical_array(tc)
tc.assumeFalse(stdlib.matlabOlderThan('R2024a'))

in = ["", "hi", "/ok", "not-exist/a/.."];

c = stdlib.canonical(in, false);
exp = ["", "hi", filesep + "ok", "not-exist"];
tc.verifyEqual(c, exp)
end

end

end
