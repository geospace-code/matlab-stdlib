classdef TestSubprocess < matlab.unittest.TestCase

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
tc.assertEqual(status, 0, err)
tc.verifyGreaterThan(strlength(msg),  0)
tc.verifyEqual(strlength(err), 0)

end


function test_cwd(tc)
import matlab.unittest.fixtures.TemporaryFolderFixture

if ispc
  c = ["cmd", "/c", "dir"];
else
  c = ["ls", "-l"];
end

fixture = tc.applyFixture(TemporaryFolderFixture);
td = fixture.Folder;

[s, m, e] = stdlib.subprocess_run(c);
tc.assertEqual(s, 0, "status non-zero")
tc.verifyGreaterThan(strlength(m), 0, "empty directory not expected")
tc.verifyEqual(strlength(e), 0, e)

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

end

end
