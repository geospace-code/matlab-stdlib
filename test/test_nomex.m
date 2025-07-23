function test_nomex()
import matlab.unittest.selectors.HasTag

cwd = fileparts(mfilename('fullpath'));

root = fileparts(cwd);
addpath(root)

if isMATLABReleaseOlderThan('R2022b')
  suite = testsuite(cwd);
else
  suite = testsuite(cwd, InvalidFileFoundAction="error");
end

sel = ~HasTag("exe") & ~HasTag("mex");

suite = suite.selectIf(sel);

r = run(testrunner(), suite);

assert(~isempty(r), "No tests were run")
assertSuccess(r)
end
