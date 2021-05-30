classdef TestSys < matlab.unittest.TestCase

methods (Test)

function test_find_fortran(tc)
tc.assertTrue(isstring(stdlib.sys.find_fortran_compiler()))
end

function test_cygwin(tc)
tc.assertTrue(islogical(stdlib.sys.iscygwin))
end

function test_octave(tc)
tc.assertTrue(islogical(stdlib.sys.isoctave))
end

function test_wsl(tc)
tc.assertTrue(islogical(stdlib.sys.iswsl))
end

function test_isinteractive(tc)
tc.assertTrue(islogical(stdlib.sys.isinteractive))
end

end
end
