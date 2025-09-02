classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2021a', 'impure'}) ...
    TestTime < matlab.unittest.TestCase

properties (TestParameter)
B_set_modtime
end


methods (TestParameterDefinition, Static)
function B_set_modtime = setupBackends()
B_set_modtime = init_backend("set_modtime");
end
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

tc.assertTrue(stdlib.touch(fn, datetime("yesterday")))
t0 = stdlib.get_modtime(fn);

ok = stdlib.set_modtime(fn, datetime("now"), B_set_modtime);

tc.assertTrue(ok)
t1 = stdlib.get_modtime(fn);

tc.verifyGreaterThanOrEqual(t1, t0)
end

end

end
