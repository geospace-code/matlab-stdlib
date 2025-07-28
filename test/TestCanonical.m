classdef TestCanonical < matlab.unittest.TestCase

properties(TestParameter)
p = {{'', ""}, ...
{"", ""}, ...
{"not-exist", "not-exist"}, ...
{"a/../b", "b"}, ...
{strcat(mfilename("fullpath"), '.m/..'), string(fullfile(stdlib.parent(mfilename("fullpath"))))}, ...
{"not-exist/a/..", "not-exist"}, ...
{"./not-exist", "not-exist"}, ...
{"../not-exist", "../not-exist"}
};
end

methods(TestClassSetup)
function pkg_path(tc)
p = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(p)
end
end


methods(Test, TestTags="impure")

function test_canonical(tc, p)
tc.verifyEqual(stdlib.canonical(p{1}), p{2})
end

end

end
