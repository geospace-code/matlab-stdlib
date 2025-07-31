function plan = buildfile
import matlab.unittest.selectors.HasTag

plan = buildplan(localfunctions);

cnomex = ~HasTag("exe") & ~HasTag("mex") & ~HasTag("java") & ~HasTag("java_exe") & ~HasTag("python");
if ispc()
  cnomex = cnomex & ~HasTag("unix");
else
  cnomex = cnomex & ~HasTag("windows");
end

pkg_root = fullfile(plan.RootFolder, "+stdlib");
test_root = fullfile(plan.RootFolder, "test");

if isMATLABReleaseOlderThan('R2025a')
  mt_ok = false;
else
  addons = matlab.addons.installedAddons;
  mt_ok = any(ismember(addons.Name, "MATLAB Test")) && license('checkout', 'MATLAB Test') == 1;
end

if ~isMATLABReleaseOlderThan("R2023b")
  plan("clean") = matlab.buildtool.tasks.CleanTask;
end

if isMATLABReleaseOlderThan("R2024b")

  plan("test_main") = matlab.buildtool.Task(Actions=@(context) test_main(context, cnomex));

  if isMATLABReleaseOlderThan('R2023b')
    return
  end

  plan("test_java") = matlab.buildtool.tasks.TestTask(test_root, Tag="java");
  plan("test_exe") = matlab.buildtool.tasks.TestTask(test_root, Tag="exe", Dependencies="exe");

elseif isMATLABReleaseOlderThan("R2025a")

  plan("test:main") = matlab.buildtool.Task(Actions=@(context) test_main(context, cnomex));

else

  plan("test:main") = matlab.buildtool.tasks.TestTask(...
    test_root, Description="Test non-MEX targets",...
    Selector=cnomex, ...
    SourceFiles=pkg_root, RunOnlyImpactedTests=mt_ok,...
    TestResults="release/TestResults_nomex.xml", Strict=true);

end


if ~isMATLABReleaseOlderThan('R2024b')

  plan("test:exe") = matlab.buildtool.tasks.TestTask(test_root, Tag="exe", Dependencies="exe");

  plan("test:python") = matlab.buildtool.tasks.TestTask(...
    test_root, Description="test Python targets", ...
    Tag = "python", ...
    TestResults="release/TestResults_java.xml", Strict=true);

  plan("test:java") = matlab.buildtool.tasks.TestTask(...
    test_root, Description="test Java targets", ...
    Tag = "java", ...
    TestResults="release/TestResults_java.xml", Strict=true);

  plan("test:java_exe") = matlab.buildtool.tasks.TestTask(...
    test_root, Description="test Java exe targets", ...
    Tag = "java_exe", Dependencies="exe", ...
    TestResults="release/TestResults_java_exe.xml", Strict=true);


  if mt_ok
    plan("coverage") = matlab.buildtool.tasks.TestTask(test_root, ...
    Description="code coverage", ...
    Dependencies="exe", ...
    SourceFiles=pkg_root, ...
    Strict=false).addCodeCoverage(...
    matlabtest.plugins.codecoverage.StandaloneReport("release/coverage-report.html"));
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

if ~isMATLABReleaseOlderThan("R2024a")
  plan("check") = matlab.buildtool.tasks.CodeIssuesTask(plan.RootFolder, ...
    IncludeSubfolders=true, ...
    WarningThreshold=0, Results="release/CodeIssues.sarif");
end

end


function publishTask(context)
% publish HTML inline documentation strings to individual HTML files
outdir = fullfile(context.Plan.RootFolder, 'docs');

publish_gen_index_html("stdlib", ...
  "A standard library of functions for Matlab.", ...
  "https://github.com/geospace-code/matlab-stdlib", ...
  outdir)
end
