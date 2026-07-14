%% TEST_MAIN Run all tests

function test_main(context, sel)
arguments
  context = []
  sel = (~HasTag('exe') & ~HasTag('java_exe')) | HasTag('native_exe')
end

import matlab.unittest.TestRunner
import matlab.unittest.selectors.HasTag


if isempty(context)
  cwd = fileparts(mfilename('fullpath'));
else
  cwd = context.Plan.RootFolder;
end
test_root = strcat(cwd, '/test');

suite = define_suite(test_root, sel);

runner = TestRunner.withTextOutput;
r = runner.run(suite);

assert(~isempty(r), 'No tests were run')

Lf = sum([r.Failed]);
Lok = sum([r.Passed]);
Lk = sum([r.Incomplete]);
Lt = numel(r);
assert(Lf == 0, sprintf('%d / %d tests failed', Lf, Lt))

if Lk
  fprintf('%d / %d tests skipped\n', Lk, Lt);
end

fprintf('%d / %d tests succeeded\n', Lok, Lt);

end


function suite = define_suite(test_root, sel)
import matlab.unittest.selectors.HasTag

if isMATLABReleaseOlderThan("R2022b")
  eact = {};
else
  eact = {'InvalidFileFoundAction', 'error'};
end

suite = testsuite(test_root, eact{:});

% selectIf takes the subset of suite tests that meet 'sel' conditions
sel = releaseTestTags(sel);

suite = suite.selectIf(sel);

end
