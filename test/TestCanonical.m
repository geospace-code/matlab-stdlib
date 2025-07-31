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
fun = {"native", "legacy"}
end

methods(TestClassSetup)
function pkg_path(tc)
fsp = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(fsp)
end
end


methods(Test, TestTags="impure")

function test_canonical(tc, p, fun)
try
  c = stdlib.canonical(p{1}, false, fun);
catch e
  tc.verifyEqual(e.identifier, 'stdlib:choose_method:NameError', e.message)
  return
end
tc.verifyEqual(c, p{2})
end

end

end
