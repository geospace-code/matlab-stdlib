classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'java_exe'}) ...
    TestSubprocessJava < SubprocessRunAbstract

properties (Constant)
  runFcn = @stdlib.subprocess_run_java
end


methods (Test, TestTags={'java_exe'})


function test_java_timeout(tc)
import matlab.unittest.constraints.StartsWithSubstring

cwd = fileparts(mfilename('fullpath'));
exe = cwd + "/sleep.exe";
tc.assumeThat(exe, matlab.unittest.constraints.IsFile)

[ret, ~, err] = tc.runFcn(exe, 'timeout', 1, 'stdout', false, 'stderr', false);

tc.verifyNotEqual(ret, 0, err)
tc.verifyThat(err, StartsWithSubstring("Subprocess timeout"))

end

end

end
