function test_nomex()
import matlab.unittest.TestSuite
import matlab.unittest.selectors.HasTag

cwd = fileparts(mfilename('fullpath'));

root = fileparts(cwd);
addpath(root)

suite = TestSuite.fromFolder(cwd);

sel = ~HasTag("exe") & ~HasTag("mex");

suite = suite.selectIf(sel);

r = run(testrunner(), suite);

assert(~isempty(r), "No tests were run")
assertSuccess(r)
end
