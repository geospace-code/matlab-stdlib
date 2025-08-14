classdef (TestTags = {'R2019b', 'impure'}) ...
    TestExists < matlab.unittest.TestCase

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
backend = init_backend({'java', 'native', 'legacy'}, 'native', ~isMATLABReleaseOlderThan('R2025a'))
backend_ps = init_backend({'python', 'sys'})
end

methods(TestClassSetup)
function test_dirs(tc)
pkg_path(tc)

tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture())
end
end

methods (Test)

function test_exists(tc, Ps)
ok = stdlib.exists(Ps{1});
tc.verifyEqual(ok, Ps{2}, Ps{1})
end


function test_is_rw(tc, Ps, backend, fname)
h = str2func("stdlib." + fname);

r = h(Ps{1}, backend);
tc.verifyEqual(r, Ps{2})
end


function test_is_rw_array(tc, backend, fname)
h = str2func("stdlib." + fname);
in =  [".",  tempname(), mfilename('fullpath') + ".m"];
out = [true, false,     true];

r = h(in, backend);
tc.verifyEqual(r, out)
end


function test_is_char_device(tc, backend_ps)
% /dev/stdin may not be available on CI systems
n = stdlib.null_file();

tc.verifyTrue(stdlib.is_char_device(n, backend_ps), n)
end

end
end
