classdef TestCanonical < matlab.unittest.TestCase

properties(TestParameter)
p = {{'', ""}, ...
{"", ""}, ...
{"not-exist", "not-exist"}, ...
{"a/../b", "b"}, ...
{strcat(mfilename("fullpath"), '.m/..'), string(fileparts(mfilename("fullpath")))}, ...
{"not-exist/a/..", "not-exist"}, ...
{"./not-exist", "not-exist"}
};
fun = {@stdlib.canonical, @stdlib.native.canonical, @stdlib.native.canonical_legacy}
end

methods(TestClassSetup)
function pkg_path(tc)
fsp = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(fsp)
end
end


methods(Test, TestTags="impure")

function test_canonical(tc, p, fun)
is_capable(tc, fun)

tc.verifyEqual(fun(p{1}, false), p{2})
end

end

end
