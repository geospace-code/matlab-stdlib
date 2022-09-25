classdef TestSys < matlab.unittest.TestCase

methods (Test)

function test_simple_run(tc)

import stdlib.sys.subprocess_run

if ispc
  c = 'dir';
else
  c = 'ls';
end
tc.verifyEqual(subprocess_run(c), 0)
end


function test_env_run(tc)

import stdlib.sys.subprocess_run

names = ["TEST1", "TEST2"];
vals = ["test123", "test321"];

env = struct(names(1), vals(1), names(2), vals(2));

% NOTE: test function cannot get specific variables without invoking a
% subshell, as echo is evaluated in current shell before &&
if ispc
  c = "set";
else
  c = "env";
end
[ret, msg] = subprocess_run(c, "env", env);
tc.verifyEqual(ret, 0)
tc.verifyTrue(contains(msg, names(1) + "=" + vals(1)) && contains(msg, names(2) + "=" + vals(2)))

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
