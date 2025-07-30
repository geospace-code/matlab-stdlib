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
isr_method = {'java', 'native', 'legacy'}
isw_method = {'java', 'native', 'legacy'}
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


function test_is_readable(tc, Ps, isr_method)
is_capable(tc, str2func("stdlib." + isr_method + ".is_readable"))

ok = stdlib.is_readable(Ps{1}, isr_method);
tc.verifyEqual(ok, Ps{2}, Ps{1})
end


function test_is_writable(tc, Ps, isw_method)
is_capable(tc, str2func("stdlib." + isw_method + ".is_writable"))

ok = stdlib.is_writable(Ps{1}, isw_method);
tc.verifyEqual(ok, Ps{2}, Ps{1})
end

function test_is_writable_dir(tc, isw_method)
is_capable(tc, str2func("stdlib." + isw_method + ".is_writable"))

tc.assumeFalse(isMATLABReleaseOlderThan('R2022a'))

td = tc.createTemporaryFolder();

tc.verifyTrue(stdlib.is_writable(td, isw_method))
end

end

end
