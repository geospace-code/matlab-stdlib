function plan = buildfile
import matlab.unittest.selectors.HasTag

plan = buildplan(localfunctions);

sel = HasTag('native_exe') | (~HasTag("exe") & ~HasTag("java") & ~HasTag("java_exe") & ~HasTag("python"));
if ispc()
  sel = sel & ~HasTag("unix");
else
  sel = sel & ~HasTag("windows");
end

reportDir = fullfile(plan.RootFolder, 'reports');
if ~isfolder(reportDir)
  mkdir(reportDir);
end
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
    TestResults=fullfile(reportDir, 'TestResults_main.xml'), Strict=true);

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
end

if ~isMATLABReleaseOlderThan('R2024a')

  plan('coverage') = matlab.buildtool.tasks.TestTask(test_root, ...
    Description="Run code coverage", ...
    Dependencies='exe', ...
    SourceFiles=pkg_root, ...
    Strict=false);
  plan('coverage').DisableIncremental = true;

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
%
% References:
% https://www.mathworks.com/help/matlab/matlab_prog/display-custom-documentation.html
% https://www.mathworks.com/help/matlab/matlab_prog/create-a-help-summary-contents-m.html
pkg_name = '+stdlib';
pkg_root = fullfile(context.Plan.RootFolder, pkg_name);
html_dir = fullfile(pkg_root, 'html');
contents = fullfile(pkg_root, "Contents.m");

% styleFile = fullfile(context.Plan.RootFolder, "private/style.css");
%
% readme = publish_gen_index_html("stdlib", ...
%   "A standard library of functions for Matlab.", ...
%   "https://github.com/geospace-code/matlab-stdlib", ...
%   html_dir, styleFile);

pkg = what(pkg_root);
funcs = string(pkg.m).';
pn = extractAfter(pkg_name, 1);

txt = ["%% Standard library of functions for MATLAB", "%"];

repo = gitrepo(pkg.path);
txt(end+1) = "% Git branch / commit: " +  repo.CurrentBranch.Name + " " + ...
  repo.LastCommit.ID{1}(1:8) + " " + string(repo.LastCommit.CommitterDate);


txt = [txt, "%", "% <https://github.com/geospace-code/matlab-stdlib GitHub Source Code>", "%", ...
"% Library Functions:", "%", ...
"% <html>", "% <table>", "% <tr><th>Function</th> <th>Description</th> <th>Backends</th></tr>"];

writelines(join(txt, newline), contents, WriteMode="overwrite")


Nbe = struct(dotnet=0, java=0, perl=0, python=0, sys=0, native=0, legacy=0, top_level=0);

for m = funcs
  Nbe.top_level = Nbe.top_level + 1;

  if m == "Contents.m"
    continue
  end

  [~, name] = fileparts(m);

  doc_fn = publish(pn + "." + name, evalCode=false, outputDir=html_dir);
  disp(doc_fn)

  % inject summary for each function
  help_txt = splitlines(string(help(pn + "." + name)));
  words = split(strip(help_txt(1)), " ");

  % error if no docstring
  fname = words(1);
  assert(endsWith(fname, name, IgnoreCase=true), "fname %s does not match name %s \nis there a docstring at the top of the .m file?", fname, name)

  line = "% <tr><td><a href=" + name + ".html>" + fname + "</a></td><td>";
  if numel(words) > 1
    line = join([line,  words(2:end).']);
  end

  req = "";
  for bkd = string(pkg.packages).'
    if ~isempty(which(pn + "." + bkd + "." + name))
      Nbe.(bkd) = Nbe.(bkd) + 1;
      req = req + " " + bkd;
    end
  end

  line = line + "</td> <td>" + req + "</td></tr>";

  writelines(line, contents, WriteMode="append")
end

writelines("% </table></html>" + newline + "%", contents, WriteMode="append")

line = "% Function counts:" + newline + "%";

for n = string(fieldnames(Nbe)).'
  line(end+1) = "% * " + n + " " + string(Nbe.(n));  %#ok<AGROW>
end

writelines(join(line, newline), contents, WriteMode="append")

readme = publish(pn + ".Contents", evalCode=false, showCode=false);

movefile(readme, html_dir + "/index.html");
readme = html_dir + "/index.html";

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
