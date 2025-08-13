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
backend = {'java', 'native', 'legacy'}
icm = {'python', 'sys'}
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

try
  r = h(Ps{1}, backend);
  tc.verifyEqual(r, Ps{2})
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
end
end


function test_is_rw_array(tc, backend, fname)
h = str2func("stdlib." + fname);
in =  [".",  tempname(), mfilename('fullpath') + ".m"];
out = [true, false,     true];
try
  r = h(in, backend);
  tc.verifyEqual(r, out)
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
end
end


function test_is_char_device(tc, icm)
% /dev/stdin may not be available on CI systems
n = stdlib.null_file();

try
  tc.verifyTrue(stdlib.is_char_device(n, icm), n)
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
end

end

end
end
