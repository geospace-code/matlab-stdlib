classdef (TestTags = {'R2019b', 'impure'}) ...
    TestSame < matlab.unittest.TestCase

properties (TestParameter)
p_same = {...
{".", pwd()}, ...
{"..", "./.."}, ...
{"..", pwd() + "/.."}, ...
{pwd(), pwd() + "/."}}

backend = {'sys', 'java', 'python', 'native'}
end

methods(TestClassSetup)
function test_dirs(tc)
  pkg_path(tc)
end
end

methods(Test)

function test_samepath(tc, p_same, backend)
tc.assertNotEmpty(which("stdlib." + backend + ".samepath"))
try
  r = stdlib.samepath(p_same{:}, backend);
  tc.verifyClass(r, 'logical')
  tc.verifyTrue(r)
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
end
end


function test_samepath_notexist(tc, backend)
t = tempname();
try
  tc.verifyFalse(stdlib.samepath("", "", backend))
  tc.verifyFalse(stdlib.samepath(t, t, backend))
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
end
end


function test_samepath_array(tc, backend)
in = [string(mfilename), string(mfilename('fullpath'))] + ".m";
try
  r = stdlib.samepath(in, fliplr(in), backend);
  tc.verifyClass(r, 'logical')
  tc.verifyEqual(r, [true, true])
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
end
end

end

end
