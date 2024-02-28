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

function test_simple_run(tc)
if ispc
  c = ["cmd", "/c", "dir"];
else
  c = 'ls';
end

[status, msg, err] = stdlib.subprocess_run(c);
tc.verifyEqual(status, 0)
tc.verifyTrue(strlength(msg) > 0)
tc.verifyTrue(strlength(err) == 0)

end


function test_env_run(tc)

names = ["TEST1", "TEST2"];
vals = ["test123", "test321"];

env = struct(names(1), vals(1), names(2), vals(2));

for i = 1:length(names)
  if ispc
    % in ComSpec, echo is a special shell cmd like "dir" -- also doesn't
    % work in python subprocess.run
    cmd = ["pwsh", "-c", "(Get-ChildItem Env:" + names(i) + ").Value"];
  else
    cmd = ["sh", "-c", "echo $" + names(i)];
  end

  [ret, out] = stdlib.subprocess_run(cmd, "env", env);
  tc.verifyEqual(ret, 0)
  tc.verifySubstring(out, vals(i))
end

end

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

end
end
