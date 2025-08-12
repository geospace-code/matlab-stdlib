classdef TestTime < matlab.unittest.TestCase

properties (TestParameter)
sm_fun = {'sys', 'java', 'python'}
end

methods(TestClassSetup)
function test_path(tc)
  pkg_path(tc)
end
end


methods (Test)

function test_get_modtime(tc)
tc.verifyEmpty(stdlib.get_modtime(""))
end


function test_touch_modtime(tc, sm_fun)
td = createTempdir(tc);
fn = td + "/modtime.txt";

tc.assertTrue(stdlib.touch(fn, datetime("yesterday")))
t0 = stdlib.get_modtime(fn);

try
  ok = stdlib.set_modtime(fn, datetime("now"), sm_fun);
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
  return
end

tc.assertTrue(ok)
t1 = stdlib.get_modtime(fn);

tc.verifyGreaterThanOrEqual(t1, t0)
end

end

end
