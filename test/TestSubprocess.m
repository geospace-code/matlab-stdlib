classdef TestSubprocess < matlab.unittest.TestCase

methods(TestClassSetup)
function java_required(tc)
tc.assumeTrue(stdlib.has_java())
end
end


methods (Test)

function test_exe_c(tc)
import matlab.unittest.constraints.IsFile

cwd = fileparts(mfilename('fullpath'));
exe = cwd + "/printer_c.exe";
tc.assumeThat(exe, IsFile, exe + " not found")

[status, msg, err] = stdlib.subprocess_run(exe);
tc.assertEqual(status, 0, err)
tc.verifyEqual(msg, "stdout")
tc.verifyEqual(err, "stderr")

end


function test_exe_fortran(tc)
import matlab.unittest.constraints.IsFile

cwd = fileparts(mfilename('fullpath'));
exe = cwd + "/printer_fortran.exe";
tc.assumeThat(exe, IsFile, exe + " not found")

[status, msg, err] = stdlib.subprocess_run(exe);
tc.assertEqual(status, 0, err)
tc.verifyEqual(msg, "stdout")
tc.verifyEqual(err, "stderr")

end


function test_cwd(tc)
tc.assumeFalse(isMATLABReleaseOlderThan("R2022a"))

if ispc
  c = ["cmd", "/c", "dir"];
else
  c = ["ls", "-l"];
end

[s, m, e] = stdlib.subprocess_run(c);
tc.assertEqual(s, 0, "status non-zero")
tc.verifyGreaterThan(strlength(m), 0, "empty directory not expected")
tc.verifyEqual(strlength(e), 0, e)

td = tc.createTemporaryFolder();

[s, mc, e] = stdlib.subprocess_run(c, cwd=td);
tc.assertEqual(s, 0, "status non-zero")
tc.verifyNotEqual(m, mc, "expected different directory to have different contents")
tc.verifyEqual(strlength(e), 0, e)

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


function test_timeout(tc)
import matlab.unittest.constraints.StartsWithSubstring

timeout = 1;

if ispc
  c = ["powershell", "-command", "Start-Sleep -s 3"];
else
  c = ["sleep", "3"];
end

[ret, ~, err] = stdlib.subprocess_run(c, "timeout", timeout);

tc.verifyNotEqual(ret, 0, err)
tc.verifyThat(err, StartsWithSubstring("Subprocess timeout"))

end

end

end
