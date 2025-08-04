classdef TestTime < matlab.unittest.TestCase

properties
td
end

properties (TestParameter)
sm_fun = {'sys', 'java', 'python'}
end

methods(TestClassSetup)
function pkg_path(tc)
p = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(p)
end
end

% per-method to avoid race conditions creating and modifying files
methods(TestMethodSetup)

function set_temp_wd(tc)
if isMATLABReleaseOlderThan('R2022a')
  tc.td = tempname();
  mkdir(tc.td);
else
  tc.td = tc.createTemporaryFolder();
end
end
end

methods(TestMethodTeardown)
function remove_temp_wd(tc)
if isMATLABReleaseOlderThan('R2022a')
  [s, m, i] = rmdir(tc.td, 's');
  if ~s, warning(i, "Failed to remove temporary directory %s: %s", tc.td, m); end
end
end
end

methods (Test)

function test_get_modtime(tc)
tc.verifyEmpty(stdlib.get_modtime(""))
end


function test_touch_modtime(tc, sm_fun)
fn = tc.td + "/modtime.txt";

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
