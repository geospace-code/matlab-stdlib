classdef TestExists < matlab.unittest.TestCase

properties(TestParameter)
Ps = {
{pwd(), true}, ...
{mfilename("fullpath") + ".m", true}, ...
{fileparts(mfilename("fullpath")) + "/../Readme.md", true}, ...
{tempname(), false}
}
% on CI matlabroot can be writable!
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


function test_is_readable(tc, Ps)
ok = stdlib.is_readable(Ps{1});
tc.verifyEqual(ok, Ps{2}, Ps{1})
end


function test_is_writable(tc, Ps)
ok = stdlib.is_writable(Ps{1});
tc.verifyEqual(ok, Ps{2}, Ps{1})
end

function test_is_writable_dir(tc)
tc.assumeFalse(isMATLABReleaseOlderThan('R2022a'))

td = tc.createTemporaryFolder();

tc.verifyTrue(stdlib.is_writable(td))
end

end

end
