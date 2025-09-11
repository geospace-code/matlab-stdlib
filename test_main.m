%% TEST_MAIN Run all tests
%
% R2021a+ needed for over half of the tests

function test_main(context, sel)
arguments
  context = []
  sel = ~HasTag("exe") & ~HasTag("java_exe")
end

import matlab.unittest.TestRunner
import matlab.unittest.selectors.HasTag

if isempty(context)
  cwd = fileparts(mfilename('fullpath'));
else
  cwd = context.Plan.RootFolder;
end
test_root = fullfile(cwd, "test");

tags = ["native_exe", releaseTestTags()];

try
  suite = testsuite(test_root, 'Tag', tags, 'InvalidFileFoundAction', "error");
catch e
  if e.identifier ~= "MATLAB:InputParser:UnmatchedParameter"
    rethrow(e)
  end
  suite = testsuite(test_root, 'Tag', tags);
end

% selectIf takes the subset of suite tests that meet "sel" conditions
suite = suite.selectIf(sel);

runner = TestRunner.withTextOutput;
r = runner.run(suite);

assert(~isempty(r), "No tests were run")

Lf = sum([r.Failed]);
Lok = sum([r.Passed]);
Lk = sum([r.Incomplete]);
Lt = numel(r);
assert(Lf == 0, sprintf("%d / %d tests failed", Lf, Lt))

if Lk
  fprintf("%d / %d tests skipped\n", Lk, Lt);
end

fprintf("%d / %d tests succeeded\n", Lok, Lt);

end
