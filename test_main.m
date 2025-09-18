%% TEST_MAIN Run all tests

function test_main(context, sel)
import matlab.unittest.TestRunner
import matlab.unittest.selectors.HasTag

if nargin < 1
  context = [];
end
if nargin < 2
  sel = (~HasTag('exe') & ~HasTag('java_exe')) | HasTag('native_exe');
end


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

try
  rtags = releaseTestTags();
catch e
  % Matlab < R2016b
  if strcmp(e.identifier, 'MATLAB:m_illegal_character')
    suite = testsuite(test_root);
    sel = sel & HasTag('R2016a');
    suite = suite.selectIf(sel);
    return
  else
    rethrow(e)
  end
end

try
  suite = testsuite(test_root, 'Tag', rtags, 'InvalidFileFoundAction', 'error');
catch e
  if ~strcmp(e.identifier, 'MATLAB:InputParser:UnmatchedParameter')
    rethrow(e)
  end

  try
    suite = testsuite(test_root, 'Tag', rtags);
  catch e
    switch e.identifier
      case {'MATLAB:expectedScalartext', 'MATLAB:expectedScalar'}
        suite = testsuite(test_root);

        assert(numel(rtags) > 0, 'No test tags found for this Matlab release')
        ts = HasTag(rtags(1));
        if numel(rtags) > 1
          for t = rtags(2:end)
            ts = ts | HasTag(t);
          end
        end
        sel = sel & ts;
    otherwise
      rethrow(e)
    end
  end
end

% selectIf takes the subset of suite tests that meet 'sel' conditions
suite = suite.selectIf(sel);

end
