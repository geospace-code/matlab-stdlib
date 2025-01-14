function plan = buildfile
plan = buildplan(localfunctions);
plan.DefaultTasks = "test";
end

function checkTask(~)
% Identify code issues (recursively all Matlab .m files)
issues = codeIssues;
assert(isempty(issues.Issues), formattedDisplayText(issues.Issues))
end

function testTask(~)
  addpath(fileparts(mfilename("fullpath")))

  r = runtests(IncludeSubfolders=true, strict=true, UseParallel=true, OutputDetail="Concise");

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
