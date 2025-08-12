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
backend = {'java', 'native', 'legacy'}
icm = {'python', 'sys'}
end

methods(TestClassSetup)
function test_dirs(tc)
  pkg_path(tc)
end
end

methods (Test, TestTags=["R2019b", "impure"])

function test_exists(tc, Ps)
ok = stdlib.exists(Ps{1});
tc.verifyEqual(ok, Ps{2}, Ps{1})
end


function test_is_rw(tc, Ps, backend, fname)
n = "stdlib." + backend + "." + fname;
h = str2func("stdlib." + fname);
tc.assertNotEmpty(which(n))
try
  r = h(Ps{1}, backend);
  tc.verifyEqual(r, Ps{2})
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
end
end


function test_is_rw_array(tc, backend, fname)
h = str2func("stdlib." + fname);
try
  r = h([".", tempname(), mfilename() + ".m"], backend);
  tc.verifyEqual(r, [true, false, true])
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
end
end


function test_is_char_device(tc, icm)
% /dev/stdin may not be available on CI systems
if ispc
  n = "NUL";
else
  n = "/dev/null";
end

tc.assertNotEmpty(which("stdlib." + icm + ".is_char_device"))

try
  y = stdlib.is_char_device(n, icm);
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
  return
end

tc.verifyTrue(y)
end

end
end
