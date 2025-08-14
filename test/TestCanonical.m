classdef (TestTags = {'R2019b', 'impure'}) ...
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
backend = init_backend({'native', 'legacy'}, 'native', ~isMATLABReleaseOlderThan('R2024a'))
end

methods(TestClassSetup)
function test_dirs(tc)
  pkg_path(tc)

  tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture())
end
end


methods(Test)

function test_canonical(tc, p, backend)
c = stdlib.canonical(p{1}, false, backend);
tc.verifyEqual(c, p{2})
end


function test_canonical_array(tc, backend)
in = ["", "hi", "/ok", "not-exist/a/.."];

c = stdlib.canonical(in, false, backend);
exp = ["", "hi", filesep + "ok", "not-exist"];
tc.verifyEqual(c, exp)
end

end

end
