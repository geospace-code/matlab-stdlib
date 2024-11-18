function plan = buildfile
plan = buildplan(localfunctions);
plan.DefaultTasks = "test";
plan("test").Dependencies = "check";
end


function checkTask(~)
% Identify code issues (recursively all Matlab .m files)
issues = codeIssues;
assert(isempty(issues.Issues), formattedDisplayText(issues.Issues))
end


function testTask(~)
r = runtests('test/', strict=true, UseParallel=false);
% UseParallel can be a lot slower, especially on Mac
assert(~isempty(r), "No tests were run")
assertSuccess(r)
end


function coverageTask(~)
import matlab.unittest.TestRunner
import matlab.unittest.Verbosity
import matlab.unittest.plugins.CodeCoveragePlugin
% import matlab.unittest.plugins.XMLPlugin
% import matlab.unittest.plugins.codecoverage.CoberturaFormat


pkg = "stdlib";

suite = testsuite("test/");

% not import to allow use of rest of buildfile with R2022b
format = matlab.unittest.plugins.codecoverage.CoverageResult;


runner = TestRunner.withTextOutput();
runner.addPlugin(...
  CodeCoveragePlugin.forPackage(pkg, ...
    IncludingSubpackages=true, Producing=format))

% runner.addPlugin(XMLPlugin.producingJUnitFormat('test-results.xml'))
% runner.addPlugin(CodeCoveragePlugin.forPackage(pkg, 'Producing', ...
%     CoberturaFormat('test-coverage.xml')))

run_results = runner.run(suite);
assert(~isempty(run_results), "no tests found")

assertSuccess(run_results)

generateHTMLReport(format.Result)
end


function publishTask(~)
% publish (generate) docs from Matlab project

% for package code -- assumes no classes and depth == 1
pkg_name = "stdlib";

pkg = what(pkg_name);

%% generate docs
cwd = fileparts(mfilename('fullpath'));
docs = fullfile(cwd, "docs");

for sub = pkg.m.'
  s = sub{1};
  [~, name] = fileparts(s);
  doc_fn = publish(pkg_name + "." + name, evalCode=false, outputDir=docs, showCode=false);
  disp(doc_fn)
end

end
