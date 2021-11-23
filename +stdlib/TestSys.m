classdef TestSys < matlab.unittest.TestCase

methods (Test)

function test_run(tc)
if ispc
  cmd = 'dir';
else
  cmd = 'ls';
end
tc.verifyEqual(stdlib.sys.subprocess_run(cmd), 0)
end

function test_find_fortran(tc)
import matlab.unittest.constraints.IsOfClass
tc.verifyThat(stdlib.sys.find_fortran_compiler(), IsOfClass('string'))
end

function test_cygwin(tc)
import matlab.unittest.constraints.IsOfClass
tc.verifyThat(stdlib.sys.iscygwin, IsOfClass('logical'))
end

function test_octave(tc)
import matlab.unittest.constraints.IsOfClass
tc.verifyThat(stdlib.sys.isoctave, IsOfClass('logical'))
end

function test_wsl(tc)
import matlab.unittest.constraints.IsOfClass
tc.verifyThat(stdlib.sys.iswsl, IsOfClass('logical'))
end

function test_isinteractive(tc)
import matlab.unittest.constraints.IsOfClass
tc.verifyThat(stdlib.sys.isinteractive, IsOfClass('logical'))
end

end
end
