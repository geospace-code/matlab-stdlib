classdef TestSys < matlab.unittest.TestCase

methods (Test)

function test_simple_run(tc)

if ispc
  c = 'dir';
else
  c = 'ls';
end

[status, msg] = stdlib.subprocess_run(c);
tc.verifyEqual(status, 0)
tc.verifyTrue(strlength(msg) > 0)

end


function test_env_run(tc)

tc.assumeFalse(verLessThan('matlab', '9.13'), "system(..., EnvName=, EnvVal=) requires Matlab R2022b+")

names = ["TEST1", "TEST2"];
vals = ["test123", "test321"];

env = struct(names(1), vals(1), names(2), vals(2));

% NOTE: test function cannot get specific variables without invoking a
% subshell, as echo is evaluated in current shell before &&
% Thus we just print the entire environment
if ispc
  c = "set";
else
  c = "env";
end

[ret, msg] = stdlib.subprocess_run(c, env=env);
tc.verifyEqual(ret, 0)
tc.verifyTrue(contains(msg, names(1) + "=" + vals(1)))
tc.verifyTrue(contains(msg, names(2) + "=" + vals(2)))

end

function test_find_fortran(tc)
tc.verifyTrue(isstring(stdlib.sys.find_fortran_compiler()))
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

end
end
