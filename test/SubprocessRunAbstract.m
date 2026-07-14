classdef (Abstract) SubprocessRunAbstract < WorkingClassDir
% Abstract base class for testing subprocess_run* functions

properties (Abstract, Constant)
% Concrete subclasses must define this
runFcn  % Function handle
end

properties
CI = is_ci()
end

properties (TestParameter)
lang_out = {"c", "fortran"}
lang_in = {"cpp", "fortran"}
end


methods (Test, TestTags={'native_exe'})
% Common tests that apply to all implementations

function test_subprocess_cwd(tc)

if ispc
  if isequal(tc.runFcn, @stdlib.subprocess_run_java)
    c = ["cmd", "/c", "cd"];
  else
    c = "cd";
  end
else
  c = "pwd";
end

% 'echo' true is optional, just for debugging command.
debug = true;

[s, m, e] = tc.runFcn(c, 'echo', debug);
tc.assertEqual(s, 0, "status non-zero")
tc.verifyGreaterThan(strlength(m), 0, "empty directory not expected")

[s, mc, ec] = tc.runFcn(c, 'cwd', matlabroot, 'echo', debug);
tc.assertEqual(s, 0, "status non-zero")

tc.verifyEqual(strlength(e), 0, e)
tc.verifyEqual(strlength(e), 0, ec)

tc.assumeFalse(strcmp(m, mc) && tc.CI, "Some CI block cwd changes")
tc.verifyNotEqual(m, mc, "expected different directory to have different contents")
end

end

methods(Test, TestTags={'exe'})


function test_subprocess_env_run(tc)

cwd = fileparts(mfilename('fullpath'));
exe = cwd + "/printenv.exe";
tc.assertThat(exe, matlab.unittest.constraints.IsFile)

names = ["TEST1", "TEST2"];
vals = ["test123", "test321"];

env = struct(names(1), vals(1), names(2), vals(2));

for i = 1:length(names)
  [ret, out] = tc.runFcn([exe, names(i)], 'env', env);
  tc.verifyEqual(ret, 0)
  tc.verifySubstring(out, vals(i))
end
end


function test_subprocess_stdout_stderr(tc, lang_out)

cwd = fileparts(mfilename('fullpath'));
exe = fullfile(cwd, "stdout_stderr_" + lang_out + ".exe");

switch lang_out
  case "fortran", tc.assumeThat(exe, matlab.unittest.constraints.IsFile)
  case {"c", "cpp"}, tc.assertThat(exe, matlab.unittest.constraints.IsFile)
  otherwise, tc.assertTrue(false, "Unknown language: " + lang_out)
end

[status, msg, err] = tc.runFcn(exe);

if ispc()
  tc.assumeNotEqual(status, -1073741515, "GCC DLLs probably not on PATH")
end

tc.assertEqual(status, 0, err)

tc.verifySubstring(msg, "stdout")
tc.verifySubstring(err, "stderr")

[status, msg] = tc.runFcn(exe, 'stdout', false);
tc.assertEqual(status, 0)
tc.verifyTrue(stdlib.strempty(msg))

[status, msg] = tc.runFcn(exe, 'stderr', false);
tc.assertEqual(status, 0)
tc.verifySubstring(msg, 'stdout')
end


function test_subprocess_stdin(tc, lang_in)

cwd = fileparts(mfilename('fullpath'));
exe = fullfile(cwd, "stdin_" + lang_in + ".exe");

switch lang_in
  case "fortran", tc.assumeThat(exe, matlab.unittest.constraints.IsFile)
  case {"c", "cpp"}, tc.assertThat(exe, matlab.unittest.constraints.IsFile)
  otherwise, tc.assertTrue(false, "Unknown language: " + lang_in)
end

[status, msg, err] = tc.runFcn(exe, 'stdin', "1 2");

if ispc()
  tc.assumeNotEqual(status, -1073741515, "GCC DLLs probably not on PATH")
end

tc.assertEqual(status, 0, err)
tc.verifyMatches(msg, "^3$")
tc.verifyTrue(stdlib.strempty(err))
end

end
end
