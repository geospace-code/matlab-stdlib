classdef TestSys < matlab.unittest.TestCase

methods (TestClassSetup)
function setup_path(tc)
import matlab.unittest.fixtures.PathFixture
cwd = fileparts(mfilename("fullpath"));
top = fullfile(cwd, "..");
tc.applyFixture(PathFixture(top))
end
end

methods (Test)

function test_find_fortran(tc)
import matlab.unittest.constraints.IsOfClass

tc.verifyThat(stdlib.find_fortran_compiler(), IsOfClass('string'))
end

function test_platform(tc)
import matlab.unittest.constraints.IsOfClass

tc.verifyThat(stdlib.iscygwin, IsOfClass('logical'))
tc.verifyThat(stdlib.isoctave, IsOfClass('logical'))

tc.verifyThat(stdlib.iswsl, IsOfClass('logical'))
tc.verifyThat(stdlib.has_wsl, IsOfClass('logical'))

tc.verifyThat(stdlib.isinteractive, IsOfClass('logical'))

tc.verifyThat(stdlib.is_windows_powershell, IsOfClass('logical'))
end

function test_is_parallel(tc)
import matlab.unittest.constraints.IsOfClass
tc.assumeTrue(stdlib.has_java)
tc.verifyThat(stdlib.is_parallel_worker, IsOfClass('logical'))
end

function test_ram(tc)

tc.assumeTrue(stdlib.has_java)

tc.verifyGreaterThan(stdlib.ram_total(), 0)
tc.verifyGreaterThan(stdlib.ram_free(), 0)

end

function test_cpu_count(tc)

tc.assumeTrue(stdlib.has_java)
tc.verifyGreaterThan(stdlib.cpu_count(), 0)

end

function test_cpu_load(tc)

tc.assumeTrue(stdlib.has_java)
tc.verifyGreaterThanOrEqual(stdlib.cpu_load(), 0)

end

end
end
