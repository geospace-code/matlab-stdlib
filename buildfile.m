function plan = buildfile
plan = buildplan(localfunctions);

plan.DefaultTasks = "test";

pkg_name = "+stdlib";

if ~isMATLABReleaseOlderThan("R2023b")
  plan("check") = matlab.buildtool.tasks.CodeIssuesTask(pkg_name, IncludeSubfolders=true);
end

if isMATLABReleaseOlderThan("R2024b")
  plan("test").Dependencies = "legacyMex";
else

  plan("test").Dependencies = "mex";
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

end


function legacyMexTask(context)

pkg_name = "+stdlib";

legacy_mex_build(context.Plan.RootFolder, fullfile(context.Plan.RootFolder, pkg_name))

end


function testTask(~)
  t = fileparts(mfilename("fullpath"));
  addpath(t)

  r = runtests("test", ...
    IncludeSubfolders=true, ...
    strict=true, ...
    UseParallel=false);
  % Parallel Computing Toolbox takes more time to startup than is worth it for this task

  assert(~isempty(r), "No tests were run")
  assertSuccess(r)
end


function coverageTask(~)
  cwd = fileparts(mfilename('fullpath'));

  coverage_run("stdlib", fullfile(cwd, "test"))
end


function publishTask(~)
  cwd = fileparts(mfilename('fullpath'));
  outdir = fullfile(cwd, "docs");

  publish_gen_index_html("stdlib", ...
    "A standard library of functions for Matlab.", ...
    "https://github.com/geospace-code/matlab-stdlib", ...
    outdir)
end
