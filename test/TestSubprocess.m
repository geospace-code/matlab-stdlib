classdef TestSubprocess < matlab.unittest.TestCase

properties
td
end

properties (TestParameter)
lang_out = {"c", "fortran"}
lang_in = {"cpp", "fortran"}
end

methods(TestClassSetup)
function set_temp_wd(tc)
if isMATLABReleaseOlderThan('R2022a')
  tc.td = tempname();
  mkdir(tc.td);
else
  tc.td = tc.createTemporaryFolder();
end
end
end

methods(TestClassTeardown)
function remove_temp_wd(tc)
if isMATLABReleaseOlderThan('R2022a')
  rmdir(tc.td, 's');
end
end
end

methods (Test, TestTags=["exe"])

function test_stdout_stderr(tc, lang_out)
import matlab.unittest.constraints.IsFile

cwd = fileparts(mfilename('fullpath'));
exe = fullfile(cwd, "stdout_stderr_" + lang_out + ".exe");
tc.assumeThat(exe, IsFile)

[status, msg] = stdlib.subprocess_run(exe);
tc.assertEqual(status, 0)
tc.verifySubstring(msg, 'stderr')
tc.verifySubstring(msg, 'stdout')

[status, msg] = stdlib.subprocess_run(exe, stdout=false);
tc.assertEqual(status, 0)
tc.verifyEqual(msg, 'stderr')

[status, msg] = stdlib.subprocess_run(exe, stderr=false);
tc.assertEqual(status, 0)
tc.verifySubstring(msg, 'stdout')
end


function test_stdin(tc, lang_in)

cwd = fileparts(mfilename('fullpath'));
exe = fullfile(cwd, "stdin_" + lang_in + ".exe");
tc.assumeThat(exe, matlab.unittest.constraints.IsFile)

[status, msg] = stdlib.subprocess_run(exe, stdin="1 2");

tc.assertEqual(status, 0)
tc.verifyEqual(msg, '3')
end


function test_cwd(tc)

if ispc
  c = 'dir';
else
  c = 'ls -l';
end

[s, m] = stdlib.subprocess_run(c, echo=true);
tc.assertEqual(s, 0, "status non-zero")
tc.verifyGreaterThan(strlength(m), 0, "empty directory not expected")

[s, mc] = stdlib.subprocess_run(c, cwd=matlabroot, echo=true);
tc.assertEqual(s, 0, "status non-zero")
tc.verifyNotEqual(m, mc, "expected different directory to have different contents")

end


function test_env_run(tc)

cwd = fileparts(mfilename('fullpath'));
exe = fullfile(cwd, 'printenv.exe');
tc.assumeThat(exe, matlab.unittest.constraints.IsFile)

env = struct(TEST1='test123', TEST2='test321');
n = fieldnames(env);

for i = 1:numel(n)
  [ret, out] = stdlib.subprocess_run(strjoin({exe, n{i}}), env=env);
  tc.verifyEqual(ret, 0)
  tc.verifySubstring(out, env.(n{i}))
end

end

end


methods (Test, TestTags=["exe", "java"])

function test_java_stdout_stderr(tc, lang_out)
import matlab.unittest.constraints.IsFile

cwd = fileparts(mfilename('fullpath'));
exe = cwd + "/stdout_stderr_" + lang_out + ".exe";
tc.assumeThat(exe, IsFile)

[status, msg, err] = stdlib.java_run(exe);
tc.assertEqual(status, 0, err)
tc.verifySubstring(msg, "stdout")
tc.verifyEqual(err, "stderr")
end


function test_java_stdin(tc, lang_in)

cwd = fileparts(mfilename('fullpath'));
exe = cwd + "/stdin_" + lang_in + ".exe";
tc.assumeThat(exe, matlab.unittest.constraints.IsFile)

[status, msg, err] = stdlib.java_run(exe, stdin="1 2");

tc.assertEqual(status, 0, err)
tc.verifyEqual(msg, "3")
tc.verifyEqual(err, "")
end


function test_java_cwd(tc)

if ispc
  c = ["cmd", "/c", "dir"];
else
  c = ["ls", "-l"];
end

[s, m, e] = stdlib.java_run(c);
tc.assertEqual(s, 0, "status non-zero")
tc.verifyGreaterThan(strlength(m), 0, "empty directory not expected")
tc.verifyEqual(strlength(e), 0, e)

[s, mc, e] = stdlib.java_run(c, cwd=tc.td);
tc.assertEqual(s, 0, "status non-zero")
tc.verifyNotEqual(m, mc, "expected different directory to have different contents")
tc.verifyEqual(strlength(e), 0, e)

end


function test_java_env_run(tc)

cwd = fileparts(mfilename('fullpath'));
exe = cwd + "/printenv.exe";
tc.assumeThat(exe, matlab.unittest.constraints.IsFile)

names = ["TEST1", "TEST2"];
vals = ["test123", "test321"];

env = struct(names(1), vals(1), names(2), vals(2));

for i = 1:length(names)
  [ret, out] = stdlib.java_run([exe, names(i)], env=env);
  tc.verifyEqual(ret, 0)
  tc.verifySubstring(out, vals(i))
end

end


function test_java_timeout(tc)
import matlab.unittest.constraints.StartsWithSubstring

cwd = fileparts(mfilename('fullpath'));
exe = cwd + "/sleep.exe";
tc.assumeThat(exe, matlab.unittest.constraints.IsFile)

[ret, ~, err] = stdlib.java_run(exe, timeout=1, stdout=false, stderr=false);

tc.verifyNotEqual(ret, 0, err)
tc.verifyThat(err, StartsWithSubstring("Subprocess timeout"))

end

end

end
