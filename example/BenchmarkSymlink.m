classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture("..")}) ...
    BenchmarkSymlink < matlab.perftest.TestCase

properties
link
target
not_exist = tempname()
end

properties(TestParameter)
is_backend
rs_backend
end

methods (TestParameterDefinition, Static)
function [is_backend, rs_backend] = setupBackend()
  is_backend = init_backend('is_symlink');
  rs_backend = init_backend('read_symlink');
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


methods (Test, TestTags={'is_symlink'})

function bench_is_symlink_exist(tc, is_backend)
tc.startMeasuring()
i = stdlib.is_symlink(tc.link, is_backend);
tc.stopMeasuring()

tc.verifyClass(i, 'logical')
tc.verifyTrue(i)
end


function bench_is_symlink_not_exist(tc, is_backend)
tc.startMeasuring()
i = stdlib.is_symlink(tc.not_exist, is_backend);
tc.stopMeasuring()

tc.verifyClass(i, 'logical')
tc.assertNotEmpty(i)
tc.verifyFalse(i)
end

end


methods (Test, TestTags={'read_symlink'})

function bench_read_symlink_exist(tc, rs_backend)
tc.startMeasuring()
i = stdlib.read_symlink(tc.link, rs_backend);
tc.stopMeasuring()

tc.verifyClass(i, 'string')
tc.verifyGreaterThan(strlength(i), 0)
end


function bench_read_symlink_not_exist(tc, rs_backend)
tc.startMeasuring()
i = stdlib.read_symlink(tc.not_exist, rs_backend);
tc.stopMeasuring()

tc.verifyClass(i, 'string')
tc.verifyEqual(strlength(i), 0)
end

end

end