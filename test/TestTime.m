classdef (TestTags = {'R2019b', 'impure'}) ...
    TestTime < matlab.unittest.TestCase

properties (TestParameter)
sm_fun = {'sys', 'java', 'python'}
end

methods(TestClassSetup)
function test_path(tc)
  pkg_path(tc)

  tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture())
end
end


methods (Test)

function test_get_modtime(tc)
tc.verifyEmpty(stdlib.get_modtime(""))
end


function test_touch_modtime(tc, sm_fun)

fn = fullfile(pwd(), class(tc));

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
