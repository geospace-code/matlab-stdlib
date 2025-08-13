function plan = buildfile
import matlab.unittest.selectors.HasTag

plan = buildplan(localfunctions);

sel = ~HasTag("exe") & ~HasTag("java") & ~HasTag("java_exe") & ~HasTag("python");
if ispc()
  sel = sel & ~HasTag("unix");
else
  sel = sel & ~HasTag("windows");
end

reportDir = fullfile(plan.RootFolder, ".buildtool");
pkg_root = fullfile(plan.RootFolder, "+stdlib");
test_root = fullfile(plan.RootFolder, "test");

if ~isMATLABReleaseOlderThan("R2023b")
  plan("clean") = matlab.buildtool.tasks.CleanTask();
end

if isMATLABReleaseOlderThan("R2024b")

  plan("test_main") = matlab.buildtool.Task(Actions=@(context) test_main(context, sel));
  plan("test_java") = matlab.buildtool.Task(Actions=@(context) test_main(context, HasTag("java")));

  plan("test") = matlab.buildtool.Task(Dependencies=["test_main", "test_java"]);

  if isMATLABReleaseOlderThan('R2023b')
    return
  end

  plan("test_java_exe") = matlab.buildtool.tasks.TestTask(test_root, Tag="java_exe", Dependencies="exe");
  plan("test_exe") = matlab.buildtool.tasks.TestTask(test_root, Tag="exe", Dependencies="exe");

  plan("test").Dependencies = [plan("test").Dependencies, "test_java_exe", "test_exe"];

elseif isMATLABReleaseOlderThan("R2025a")
  % Matlab == R2024b
  plan("test:main") = matlab.buildtool.Task(Actions=@(context) test_main(context, sel));

else
  % Matlab >= R2025a
  plan("test:main") = matlab.buildtool.tasks.TestTask(...
    test_root, Description="Test most targets", ...
    Selector=sel, ...
    SourceFiles=pkg_root, ...
    RunOnlyImpactedTests=stdlib.checkout_license("MATLAB Test"), ...
    TestResults=reportDir + "/TestResults_main.xml", Strict=true);

  plan("test").Description = "Run all self-tests";

end


if ~isMATLABReleaseOlderThan('R2024b')

  plan("test:exe") = matlab.buildtool.tasks.TestTask(test_root, Tag="exe", Dependencies="exe");

  plan("test:python") = matlab.buildtool.tasks.TestTask(...
    test_root, Description="test Python targets", ...
    Tag = "python", Strict=true);

  plan("test:java") = matlab.buildtool.tasks.TestTask(...
    test_root, Description="test Java targets", ...
    Tag = "java", Strict=true);

  plan("test:java_exe") = matlab.buildtool.tasks.TestTask(...
    test_root, Description="test Java exe targets", ...
    Tag = "java_exe", Dependencies="exe", Strict=true);


  plan("coverage") = matlab.buildtool.tasks.TestTask(test_root, ...
    Description="Run code coverage", ...
    Dependencies="exe", ...
    SourceFiles=pkg_root, ...
    Strict=false);

  coverageReport = fullfile(reportDir, 'coverage-report.html');
  if stdlib.checkout_license("MATLAB Test")
    plan("coverage").addCodeCoverage(matlabtest.plugins.codecoverage.StandaloneReport(coverageReport));
  else
    plan("coverage").addCodeCoverage(coverageReport);
  end
end

srcs = ["stdout_stderr_c.c", "stdin_cpp.cpp", "printenv.cpp", "sleep.cpp"];
if ~isempty(get_compiler("fortran"))
  srcs = [srcs, "stdout_stderr_fortran.f90", "stdin_fortran.f90"];
end
[~, exes] = fileparts(srcs);
exes = exes + ".exe";

srcs = fullfile(test_root, srcs);
exes = fullfile(test_root, exes);

plan("exe") = matlab.buildtool.Task(Inputs=srcs, Outputs=exes, Actions=@build_exe, ...
                 Description="build demo executables for testing java_run");

end


function publishTask(context)
% publish HTML inline documentation strings to individual HTML files
outdir = fullfile(context.Plan.RootFolder, 'docs');
styleFile = fullfile(context.Plan.RootFolder, "private/style.css");

readme = publish_gen_index_html("stdlib", ...
  "A standard library of functions for Matlab.", ...
  "https://github.com/geospace-code/matlab-stdlib", ...
  outdir, styleFile);

fprintf("\nweb('file:///%s') to view docs\n\n", readme);
end


function checkTask(context)
root = context.Plan.RootFolder;

c = codeIssues(root, IncludeSubfolders=true);

if isempty(c.Issues)
  fprintf('%d files checked OK with %s under %s\n', numel(c.Files), c.Release, root)
else
  disp(c.Issues)
  error("Errors found in " + join(c.Issues.Location, newline))
end

end
