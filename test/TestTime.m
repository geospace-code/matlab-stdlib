classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2017a'}) ...
    TestTime < matlab.unittest.TestCase

properties (TestParameter)
B_jps = {'java', 'python', 'sys'}
B_dps = {'dotnet', 'python', 'sys'}
end


methods(TestClassSetup)
function test_path(tc)
tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture());
end
end


methods (Test)

function test_get_modtime(tc)
tc.verifyEmpty(stdlib.get_modtime(''))
end


function test_touch_modtime(tc, B_jps)

fn = 'touch.txt';

tc.assertTrue(stdlib.touch(fn))
t0 = stdlib.get_modtime(fn);

ok = stdlib.set_modtime(fn, datetime('tomorrow'), B_jps);

if ismember(B_jps, stdlib.Backend().select('set_modtime'))
  tc.assertTrue(ok)
  t1 = stdlib.get_modtime(fn);
  tc.verifyGreaterThanOrEqual(t1, t0)
else
  tc.assertEmpty(ok)
end
end


function test_uptime(tc, B_dps)

if ismember(B_dps, stdlib.Backend().select('uptime'))
  t1 = stdlib.uptime(B_dps);
  tc.verifyGreaterThanOrEqual(t1, 0);
  tc.verifyClass(t1, 'double')
else
  t1 = stdlib.uptime(B_dps);
  tc.verifyEmpty(t1)
end
end

end
end
