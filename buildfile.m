function plan = buildfile
import matlab.unittest.selectors.HasTag

plan = buildplan(localfunctions);

if isMATLABReleaseOlderThan("R2023b")
  plan("clean") = matlab.buildtool.Task();
else
  plan("clean") = matlab.buildtool.tasks.CleanTask;
end

cnomex = ~HasTag("exe") & ~HasTag("mex") & ~HasTag("java") & ~HasTag("python");
if ispc()
  cnomex = cnomex & ~HasTag("unix");
else
  cnomex = cnomex & ~HasTag("windows");
end

% cmex = HasTag("mex");

cjava = HasTag("java") & ~HasTag("exe");

pkg_root = fullfile(plan.RootFolder, "+stdlib");
test_root = fullfile(plan.RootFolder, "test");

if isMATLABReleaseOlderThan("R2023b")
  plan("test_exe") = matlab.buildtool.Task(Actions=@(context) legacy_test(context, HasTag("exe")), Dependencies="exe");
elseif isMATLABReleaseOlderThan("R2024b")
  plan("test_exe") = matlab.buildtool.tasks.TestTask(test_root, Tag="exe", Dependencies="exe");
end

if isMATLABReleaseOlderThan("R2024b")

  plan("test_java") = matlab.buildtool.Task(Actions=@(context) legacy_test(context, cjava));
  plan("test_main") = matlab.buildtool.Task(Actions=@(context) legacy_test(context, cnomex));

elseif isMATLABReleaseOlderThan("R2025a")
  % Matlab == R2024b
  plan("test:java")  = matlab.buildtool.Task(Actions=@(context) legacy_test(context, cjava));
  plan("test:exe")   = matlab.buildtool.tasks.TestTask(test_root, Tag="exe", Dependencies="exe");
  plan("test:main") = matlab.buildtool.Task(Actions=@(context) legacy_test(context, cnomex));
  % plan("test:mex")   = matlab.buildtool.Task(Actions=@(context) legacy_test(context, cmex), Dependencies="mex");

else
  % Matlab >= R2025a
  plan("test:exe")   = matlab.buildtool.tasks.TestTask(test_root, Tag="exe", Description="test subprocess",...
                         SourceFiles=[pkg_root, test_root + ["/*.cpp", "/*.c", "/*.f90"]], ...
                         RunOnlyImpactedTests=true,...
                         Dependencies="exe", TestResults="TestResults_exe.xml", Strict=true);

  plan("test:main") = matlab.buildtool.tasks.TestTask(test_root, Description="Test non-MEX targets",...
                         Selector=cnomex, ...
                         SourceFiles=pkg_root, RunOnlyImpactedTests=true,...
                         TestResults="TestResults_nomex.xml", Strict=true);

  % plan("test:mex")   = matlab.buildtool.tasks.TestTask(test_root, Description="Test mex targts",...
  %                        Selector=cmex, ...
  %                        SourceFiles=[pkg_root, plan.RootFolder + "/src"], RunOnlyImpactedTests=true,...
  %                        Dependencies="mex", TestResults="TestResults_mex.xml", Strict=true);

  plan("test:java") = matlab.buildtool.tasks.TestTask(test_root, Description="test Java targets", ...
                         Selector=cjava, ...
                         SourceFiles=pkg_root, RunOnlyImpactedTests=true,...
                         TestResults="TestResults_java.xml", Strict=true);

  addons = matlab.addons.installedAddons;
  if contains(addons.Name, "Matlab Test")
    plan("coverage") = matlab.buildtool.tasks.TestTask(test_root, ...
    Description="code coverage", ...
    Dependencies="exe", ...
    SourceFiles=pkg_root, ...
    Selector=cnomex | HasTag("java") | HasTag("exe") | HasTag("python"), ...
    Strict=false).addCodeCoverage(matlabtest.plugins.codecoverage.StandaloneReport("coverage-report.html"));
  end

  % plan("clean_mex") = matlab.buildtool.Task(Actions=@clean_mex, Description="Clean only MEX files to enable incremental tests");
end

if isMATLABReleaseOlderThan("R2023a"), return, end

srcs = ["stdout_stderr_c.c", "stdin_cpp.cpp", "printenv.cpp", "sleep.cpp"];
exes = ["stdout_stderr_c.exe", "stdin_cpp.exe", "printenv.exe", "sleep.exe"];
if ~isempty(get_compiler("fortran"))
  srcs = [srcs, "stdout_stderr_fortran.f90", "stdin_fortran.f90"];
  exes = [exes, "stdout_stderr_fortran.exe", "stdin_fortran.exe"];
end

srcs = fullfile(test_root, srcs);
exes = fullfile(test_root, exes);

plan("exe") = matlab.buildtool.Task(Inputs=srcs, Outputs=exes, Actions=@build_exe, ...
                 Description="build test exe's for test subprocess");

if ~isMATLABReleaseOlderThan("R2024a")
  plan("check") = matlab.buildtool.tasks.CodeIssuesTask(plan.RootFolder, ...
    IncludeSubfolders=true, ...
    WarningThreshold=0, Results="CodeIssues.sarif");
end


%% MexTask
if ~isMATLABReleaseOlderThan("R2024b")
% for s = get_mex_sources()
%   src = s{1};
%   [~, name] = fileparts(src(1));
%
% % name of MEX target function is name of first source file
%   plan("mex:" + name) = matlab.buildtool.tasks.MexTask(src, pkg_root, ...
%     Description="Build MEX target " + name, ...
%     Options=get_compiler_options());
% end
end

end


% function clean_mex(context)
% run(context.Plan, "clean", {"mex"});
% end


function legacy_test(context, sel)
import matlab.unittest.TestSuite

suite = TestSuite.fromFolder(fullfile(context.Plan.RootFolder, 'test'));
suite = suite.selectIf(sel);

runner = testrunner();

r = run(runner, suite);

assert(~isempty(r), "No tests were run")
assertSuccess(r)
end


function publishTask(context)
% publish HTML inline documentation strings to individual HTML files
outdir = fullfile(context.Plan.RootFolder, 'docs');

publish_gen_index_html("stdlib", ...
  "A standard library of functions for Matlab.", ...
  "https://github.com/geospace-code/matlab-stdlib", ...
  outdir)
end


function srcs = get_mex_sources(build_all)
arguments (Input)
  build_all (1,1) logical = false
end
arguments (Output)
  srcs cell
end

srcs = {
% "src/remove.cpp", ...
%["src/normalize.cpp", "src/normalize_fs.cpp", "src/pure.cpp"], ...
% "src/set_permissions.cpp"
};

if ~stdlib.has_python() || build_all
srcs{end+1} = "src/is_char_device.cpp";
srcs{end+1} = ["src/is_admin.cpp", "src/admin_fs.cpp"];
% srcs{end+1} = "src/disk_available.cpp";
% srcs{end+1} = "src/disk_capacity.cpp";
end

end
