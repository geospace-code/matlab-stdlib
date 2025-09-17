classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2019b'}) ...
    TestSubprocess < matlab.unittest.TestCase

properties
CI = is_ci()
end

properties (TestParameter)
lang_out = {"c", "fortran"}
lang_in = {"cpp", "fortran"}
end


methods(TestClassSetup)
function test_dirs(tc)
tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture())
end
end


methods (Test, TestTags = {'native_exe'})

function test_cwd(tc)

if ispc
  c = 'cd';
else
  c = 'pwd';
end

% true for debugging echo of command.
cmd_echo = false;

[s, m] = stdlib.subprocess_run(c, 'echo', cmd_echo);
tc.assertEqual(s, 0, "status non-zero")
tc.verifyGreaterThan(strlength(m), 0, "empty directory not expected")

[s, mc] = stdlib.subprocess_run(c, 'cwd', matlabroot, 'echo', cmd_echo);
tc.assertEqual(s, 0, "status non-zero")

tc.assumeFalse(strcmp(m, mc) && tc.CI, "Some CI block cwd changes")

tc.verifyNotEqual(m, mc, sprintf('same directories: CI %d', tc.CI))

end

end


methods (Test, TestTags={'exe'})
% these tests require the presence of test executables compiled by
%   buildtool exe
% The test "buildtool test:exe" automatically builds them

function test_stdout_stderr(tc, lang_out)

cwd = fileparts(mfilename('fullpath'));
exe = fullfile(cwd, "stdout_stderr_" + lang_out + ".exe");
tc.assumeThat(exe, matlab.unittest.constraints.IsFile)

[status, msg] = stdlib.subprocess_run(exe);

if ispc()
  tc.assumeNotEqual(status, -1073741515, "GCC DLLs probably not on PATH")
end

tc.assertEqual(status, 0)
tc.verifySubstring(msg, 'stderr')
tc.verifySubstring(msg, 'stdout')

[status, msg] = stdlib.subprocess_run(exe, 'stdout', false);
tc.assertEqual(status, 0)
tc.verifyEqual(msg, 'stderr')

[status, msg] = stdlib.subprocess_run(exe, 'stderr', false);
tc.assertEqual(status, 0)
tc.verifySubstring(msg, 'stdout')
end


function test_stdin(tc, lang_in)

cwd = fileparts(mfilename('fullpath'));
exe = fullfile(cwd, "stdin_" + lang_in + ".exe");
tc.assumeThat(exe, matlab.unittest.constraints.IsFile)

[status, msg] = stdlib.subprocess_run(exe, 'stdin', "1 2");

if ispc()
  tc.assumeNotEqual(status, -1073741515, "GCC DLLs probably not on PATH")
end

tc.assertEqual(status, 0)
tc.verifyEqual(msg, '3')
end


function test_env_run(tc)

cwd = fileparts(mfilename('fullpath'));
exe = fullfile(cwd, 'printenv.exe');
tc.assumeThat(exe, matlab.unittest.constraints.IsFile)

env = struct('TEST1', 'test123', 'TEST2', 'test321');
n = fieldnames(env);

for i = 1:numel(n)
  [ret, out] = stdlib.subprocess_run(strjoin({exe, n{i}}), 'env', env);
  tc.verifyEqual(ret, 0)
  tc.verifySubstring(out, env.(n{i}))
end

end

end


methods (Test, TestTags={'java_exe'})

function test_Java_stdout_stderr(tc, lang_out)

cwd = fileparts(mfilename('fullpath'));
exe = cwd + "/stdout_stderr_" + lang_out + ".exe";

switch lang_out
  case "fortran", tc.assumeThat(exe, matlab.unittest.constraints.IsFile)
  case {"c", "cpp"}, tc.assertThat(exe, matlab.unittest.constraints.IsFile)
  otherwise, tc.assertTrue(false, "Unknown language: " + lang_out)
end

[status, msg, err] = stdlib.java_run(exe);

if ispc()
  tc.assumeNotEqual(status, -1073741515, "GCC DLLs probably not on PATH")
end

tc.assertEqual(status, 0, err)
tc.verifySubstring(msg, "stdout")
tc.verifyEqual(err, "stderr")
end


function test_java_stdin(tc, lang_in)

cwd = fileparts(mfilename('fullpath'));
exe = cwd + "/stdin_" + lang_in + ".exe";

switch lang_in
  case "fortran", tc.assumeThat(exe, matlab.unittest.constraints.IsFile)
  case {"c", "cpp"}, tc.assertThat(exe, matlab.unittest.constraints.IsFile)
  otherwise, tc.assertTrue(false, "Unknown language: " + lang_in)
end

[status, msg, err] = stdlib.java_run(exe, 'stdin', "1 2");

if ispc()
  tc.assumeNotEqual(status, -1073741515, "GCC DLLs probably not on PATH")
end

tc.assertEqual(status, 0, err)
tc.verifyEqual(msg, "3")
tc.verifyEqual(err, "")
end


function test_java_cwd(tc)

if ispc
  c = ["cmd", "/c", "cd"];
else
  c = "pwd";
end

[s, m, e] = stdlib.java_run(c);
tc.assertEqual(s, 0, "status non-zero")
tc.verifyGreaterThan(strlength(m), 0, "empty directory not expected")
tc.verifyEqual(strlength(e), 0, e)

[s, mc, e] = stdlib.java_run(c, 'cwd', matlabroot);
tc.assertEqual(s, 0, "status non-zero")
tc.verifyNotEqual(m, mc, "expected different directory to have different contents")
tc.verifyEqual(strlength(e), 0, e)

end


function test_java_env_run(tc)

cwd = fileparts(mfilename('fullpath'));
exe = cwd + "/printenv.exe";
tc.assertThat(exe, matlab.unittest.constraints.IsFile)

names = ["TEST1", "TEST2"];
vals = ["test123", "test321"];

env = struct(names(1), vals(1), names(2), vals(2));

for i = 1:length(names)
  [ret, out] = stdlib.java_run([exe, names(i)], 'env', env);
  tc.verifyEqual(ret, 0)
  tc.verifySubstring(out, vals(i))
end

end


function test_java_timeout(tc)
import matlab.unittest.constraints.StartsWithSubstring

cwd = fileparts(mfilename('fullpath'));
exe = cwd + "/sleep.exe";
tc.assumeThat(exe, matlab.unittest.constraints.IsFile)

[ret, ~, err] = stdlib.java_run(exe, 'timeout', 1, 'stdout', false, 'stderr', false);

tc.verifyNotEqual(ret, 0, err)
tc.verifyThat(err, StartsWithSubstring("Subprocess timeout"))

end

end

end
