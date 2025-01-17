function plan = buildfile
plan = buildplan();

plan.DefaultTasks = "test";

pkg_name = "+stdlib";

addpath(plan.RootFolder)

if isMATLABReleaseOlderThan("R2023b")
  plan("test") = matlab.buildtool.Task(Actions=@legacyTestTask);
else
  plan("check") = matlab.buildtool.tasks.CodeIssuesTask(pkg_name, IncludeSubfolders=true);
  plan("test") = matlab.buildtool.tasks.TestTask("test", Strict=true);
end

if ~isMATLABReleaseOlderThan("R2024a")
 plan("coverage") = matlab.buildtool.tasks.TestTask(Description="code coverage", Dependencies="clean", SourceFiles="test", Strict=true, CodeCoverageResults="code-coverage.xml");
end

plan("publish") = matlab.buildtool.Task(Description="HTML inline doc generate", Actions=@publishTask);


if isMATLABReleaseOlderThan("R2024b")
  plan("mex") = matlab.buildtool.Task(Actions=@legacyMexTask);
else
  plan("clean") = matlab.buildtool.tasks.CleanTask;

  [compiler_id, compiler_opt] = get_compiler_options();

  srcs = get_mex_sources(plan.RootFolder);

  bindir = fullfile(plan.RootFolder, pkg_name);

  for s = srcs
    src = s{1};
    [~, name] = fileparts(src(1));

    plan("mex:" + name) = matlab.buildtool.tasks.MexTask(src, bindir, ...
      Options=[compiler_id, compiler_opt]);
  end
end

plan("mex").Description = "MEX build";

end


function legacyMexTask(context)
legacy_mex_build(context.Plan.RootFolder, fullfile(context.Plan.RootFolder, "+stdlib"))
end


function legacyTestTask(context)
r = runtests(fullfile(context.Plan.RootFolder, "test"), Strict=true);
% Parallel Computing Toolbox takes more time to startup than is worth it for this task

assert(~isempty(r), "No tests were run")
assertSuccess(r)
end


function publishTask(context)
outdir = fullfile(context.Plan.RootFolder, "docs");

publish_gen_index_html("stdlib", ...
  "A standard library of functions for Matlab.", ...
  "https://github.com/geospace-code/matlab-stdlib", ...
  outdir)
end
