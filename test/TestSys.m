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

function test_cygwin(tc)
tc.verifyTrue(islogical(stdlib.sys.iscygwin))
end

function test_octave(tc)
tc.verifyTrue(islogical(stdlib.sys.isoctave))
end

function test_wsl(tc)
tc.verifyTrue(islogical(stdlib.sys.iswsl))
tc.verifyTrue(islogical(stdlib.sys.has_wsl))
end

function test_isinteractive(tc)
tc.verifyTrue(islogical(stdlib.sys.isinteractive))
end

function test_isparallel(tc)

tc.verifyTrue(islogical(stdlib.sys.is_parallel_worker()))

end

function test_is_pwsh(tc)

tc.verifyTrue(islogical(stdlib.sys.is_windows_powershell()))

end

function test_ram(tc)

tc.verifyGreaterThan(stdlib.sys.ram_total(), 0)
tc.verifyGreaterThan(stdlib.sys.ram_free(), 0)

end

function test_cpu(tc)

tc.verifyGreaterThanOrEqual(stdlib.sys.cpu_load(), 0)

end

end
end
