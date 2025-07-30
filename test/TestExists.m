classdef TestExists < matlab.unittest.TestCase

properties(TestParameter)
Ps = {
{pwd(), true}, ...
{mfilename("fullpath") + ".m", true}, ...
{fileparts(mfilename("fullpath")) + "/../Readme.md", true}, ...
{tempname(), false}, ...
{'', false}, ...}
{"", false}
}
% on CI matlabroot can be writable!
fname = {'is_readable', 'is_writable'}
method = {'java', 'native', 'legacy'}
end

methods(TestClassSetup)
function pkg_path(tc)
p = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(p)
end
end

methods (Test, TestTags="impure")

function test_exists(tc, Ps)
ok = stdlib.exists(Ps{1});
tc.verifyEqual(ok, Ps{2}, Ps{1})
end


function test_is_rw(tc, Ps, method, fname)
n = "stdlib." + method + "." + fname;
h = str2func("stdlib." + fname);
tc.assertNotEmpty(which(n))
try
  tc.verifyEqual(h(Ps{1}, method), Ps{2})
catch e
  tc.verifyEqual(e.identifier, 'stdlib:choose_method:NameError')
end
end

end
end
