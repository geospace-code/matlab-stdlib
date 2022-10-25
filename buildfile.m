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
r = runtests('stdlib.test', strict=true, UseParallel=true);
assert(~isempty(r), "No tests were run")
assertSuccess(r)
end

function publishTask(~)
% publish (generate) docs from Matlab project

% for package code -- assumes no classes and depth == 1
pkg_name = 'stdlib';

r = codeIssues;
files = r.Files;

% remove nuisance functions
i = contains(files, [mfilename, "buildfile.m", filesep + "private" + filesep, filesep + "+test" + filesep]);
files(i) = [];

pkg = what(pkg_name);
subs = pkg.packages;

%% generate docs
cwd = fileparts(mfilename('fullpath'));
docs = fullfile(cwd, "docs");

for sub = subs.'
  s = sub{1};
  i = contains(files, filesep + "+" + s + filesep);
  fs = files(i);
  for f = fs.'
    [~, name, ext] = fileparts(f);
    if ext == ".m"
      doc_fn = publish(pkg_name + "." + s + "." + name, evalCode=false, outputDir=docs, showCode=false);
      disp(doc_fn)
    end
  end
end

end
