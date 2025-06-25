function test_nomex()
import matlab.unittest.TestSuite
import matlab.unittest.selectors.HasTag

suite = TestSuite.fromFolder(fileparts(mfilename('fullpath')));

sel = ~HasTag("exe") & ~HasTag("mex") & ~HasTag("symlink");

suite = suite.selectIf(sel);

runner = testrunner();

r = run(runner, suite);

assert(~isempty(r), "No tests were run")
assertSuccess(r)
end
