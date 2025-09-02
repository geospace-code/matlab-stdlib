classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'impure'}) ...
  TestCanonical < matlab.unittest.TestCase

properties (TestParameter)
p = {{'', ""}, ...
{"", ""}, ...
{"not-exist", "not-exist"}, ...
{"a/../b", "a/../b"}, ...
{strcat(mfilename("fullpath"), '.m/..'), string(fileparts(mfilename("fullpath")))}, ...
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
[c, b] = stdlib.canonical(p{1}, false);
tc.verifyEqual(c, p{2})

if stdlib.matlabOlderThan('R2024a')
  tc.verifyEqual(b, 'legacy')
else
  tc.verifyEqual(b, 'native')
end
end

function test_legacy_canonical(tc, p)
c = stdlib.legacy.canonical(p{1}, false);
tc.verifyEqual(c, p{2})
end
end


methods (Test, TestTags={'R2024a'})
function test_canonical_array(tc)
tc.assumeFalse(stdlib.matlabOlderThan('R2024a'))

in = ["", "hi", "/ok"];

c = stdlib.canonical(in, false);
exp = ["", "hi", "/ok"];
tc.verifyEqual(c, exp)
end
end

end
