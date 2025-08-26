classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture("..")}) ...
    BenchmarkIsSymlink < matlab.perftest.TestCase

properties
link
target
not_exist = tempname()
fun = @stdlib.is_symlink
end

properties(TestParameter)
backend
end

methods (TestParameterDefinition, Static)
function backend = setupBackend()
  backend = init_backend('is_symlink');
end
end


methods(TestClassSetup)
function setup_symlink(tc)
tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture())

tc.link = fullfile(pwd(), 'my.lnk');

tc.target = [mfilename("fullpath") '.m'];

tc.assertTrue(stdlib.create_symlink(tc.target, tc.link))
end
end


methods (Test)

function bench_exist(tc, backend)
tc.startMeasuring()
i = tc.fun(tc.link, backend);
tc.stopMeasuring()

tc.verifyClass(i, 'logical')
tc.verifyTrue(i)
end


function bench_not_exist(tc, backend)
tc.startMeasuring()
i = tc.fun(tc.not_exist, backend);
tc.stopMeasuring()

tc.verifyClass(i, 'logical')
tc.assertNotEmpty(i)
tc.verifyFalse(i)
end

end

end