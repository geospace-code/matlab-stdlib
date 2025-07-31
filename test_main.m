function test_main(context, sel)
arguments
  context {mustBeScalarOrEmpty} = []
  sel {mustBeScalarOrEmpty} = ~HasTag("exe") & ~HasTag("mex") & ~HasTag("java_exe")
end

import matlab.unittest.TestRunner
import matlab.unittest.selectors.HasTag

if isempty(context)
  cwd = fileparts(mfilename('fullpath'));
else
  cwd = context.Plan.RootFolder;
end
test_root = fullfile(cwd, "test");

if isMATLABReleaseOlderThan('R2022b')
  suite = testsuite(test_root);
else
  suite = testsuite(test_root, 'InvalidFileFoundAction', "error");
end

suite = suite.selectIf(sel);

runner = TestRunner.withTextOutput;
r = runner.run(suite);

assert(~isempty(r), "No tests were run")
assertSuccess(r)

end
