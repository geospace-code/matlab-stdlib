classdef TestSame < matlab.unittest.TestCase

properties (TestParameter)
p_same = {...
{".", pwd()}, ...
{"..", "./.."}, ...
{"..", pwd() + "/.."}, ...
{pwd(), pwd() + "/."}}

fun = {'sys', 'java', 'python', 'native'}
end

methods(TestClassSetup)
function pkg_path(tc)
p = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(p)
end
end

methods(Test)

function test_samepath(tc, p_same, fun)
tc.assertNotEmpty(which("stdlib." + fun + ".samepath"))
try
  y = stdlib.samepath(p_same{:}, fun);
  tc.verifyTrue(y)
catch e
  tc.verifyEqual(e.identifier, 'stdlib:choose_method:NameError', e.message)
end
end


function test_samepath_notexist(tc, fun)
t = tempname();
try
  tc.verifyFalse(stdlib.samepath("", "", fun))
  tc.verifyFalse(stdlib.samepath(t, t, fun))
catch e
  tc.verifyEqual(e.identifier, 'stdlib:choose_method:NameError', e.message)
end
end

end

end
