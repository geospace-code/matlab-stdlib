classdef TestTime < matlab.unittest.TestCase

properties
td
end

properties (TestParameter)
set_modtime_fun = {@stdlib.set_modtime, @stdlib.sys.set_modtime, @stdlib.java.set_modtime, @stdlib.python.set_modtime}
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


function test_touch_modtime(tc, set_modtime_fun)
is_capable(tc, set_modtime_fun)

fn = tc.td + "/modtime.txt";

tc.verifyTrue(stdlib.touch(fn, datetime("yesterday")))
t0 = stdlib.get_modtime(fn);

tc.verifyTrue(set_modtime_fun(fn, datetime("now")))
t1 = stdlib.get_modtime(fn);

tc.verifyGreaterThanOrEqual(t1, t0)
end

end

end
