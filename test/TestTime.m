classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2017b'}) ...
    TestTime < matlab.unittest.TestCase

properties (TestParameter)
B_set_modtime = {'java', 'python', 'sys'}
end


methods(TestClassSetup)
function test_path(tc)
tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture())
end
end


methods (Test)

function test_get_modtime(tc)
tc.verifyEmpty(stdlib.get_modtime(""))
end


function test_touch_modtime(tc, B_set_modtime)

fn = 'touch.txt';

tc.assertTrue(stdlib.touch(fn))
t0 = stdlib.get_modtime(fn);

ok = stdlib.set_modtime(fn, datetime("tomorrow"), B_set_modtime);

if ismember(B_set_modtime, stdlib.Backend().select('set_modtime'))
  tc.assertTrue(ok)
  t1 = stdlib.get_modtime(fn);
  tc.verifyGreaterThanOrEqual(t1, t0)
else
  tc.assertEmpty(ok)
end
end

end

end
