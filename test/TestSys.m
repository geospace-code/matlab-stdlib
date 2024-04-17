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

tc.verifyThat(stdlib.sys.find_fortran_compiler(), IsOfClass('string'))
end

function test_platform(tc)
import matlab.unittest.constraints.IsOfClass

tc.verifyThat(stdlib.sys.iscygwin, IsOfClass('logical'))
tc.verifyThat(stdlib.sys.isoctave, IsOfClass('logical'))

tc.verifyThat(stdlib.sys.iswsl, IsOfClass('logical'))
tc.verifyThat(stdlib.sys.has_wsl, IsOfClass('logical'))

tc.verifyThat(stdlib.sys.isinteractive, IsOfClass('logical'))

tc.verifyThat(stdlib.sys.is_parallel_worker, IsOfClass('logical'))

tc.verifyThat(stdlib.sys.is_windows_powershell, IsOfClass('logical'))

end

function test_ram(tc)

tc.verifyGreaterThan(stdlib.sys.ram_total(), 0)
tc.verifyGreaterThan(stdlib.sys.ram_free(), 0)

end

function test_cpu_count(tc)

tc.verifyGreaterThan(stdlib.sys.cpu_count(), 0)

end

function test_cpu_load(tc)

tc.verifyGreaterThanOrEqual(stdlib.sys.cpu_load(), 0)

end

end
end
