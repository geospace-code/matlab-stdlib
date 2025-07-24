classdef TestTime < matlab.unittest.TestCase

properties
td
end

methods(TestClassSetup)
function set_temp_wd(tc)
if isMATLABReleaseOlderThan('R2022a')
  tc.td = tempname();
  mkdir(tc.td);
else
  tc.td = tc.createTemporaryFolder();
end
end
end

methods(TestClassTeardown)
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


function test_touch_modtime(tc)
fn = tc.td + "/modtime.txt";

tc.verifyTrue(stdlib.touch(fn, datetime("yesterday")))
t0 = stdlib.get_modtime(fn);

tc.verifyTrue(stdlib.set_modtime(fn, datetime("now")))
t1 = stdlib.get_modtime(fn);

tc.verifyGreaterThanOrEqual(t1, t0)
end

end


methods(Test, TestTags="shell")

function test_set_modtime_sys(tc)
fn = tc.td + "/modtime.txt";

tc.verifyTrue(stdlib.touch(fn, datetime("yesterday")))
t0 = stdlib.get_modtime(fn);

tc.verifyTrue(stdlib.set_modtime(fn, datetime("now")))
t1 = stdlib.get_modtime(fn);

tc.verifyGreaterThanOrEqual(t1, t0);
end

end

end
