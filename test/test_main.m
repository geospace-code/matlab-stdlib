function test_main()
import matlab.unittest.TestRunner
import matlab.unittest.selectors.HasTag

sel = ~HasTag("exe") & ~HasTag("mex");

cwd = fileparts(mfilename('fullpath'));

if isMATLABReleaseOlderThan('R2022b')
  suite = testsuite(cwd);
else
  suite = testsuite(cwd, 'InvalidFileFoundAction', "error");
end

suite = suite.selectIf(sel);

runner = TestRunner.withTextOutput;
r = runner.run(suite);

assert(~isempty(r), "No tests were run")
assertSuccess(r)

end
