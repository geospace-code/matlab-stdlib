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

bindir = fullfile(plan.RootFolder, pkg_name);
if isMATLABReleaseOlderThan("R2024b")
  plan("mex") = matlab.buildtool.Task(Actions=@(~)legacyMexTask(bindir));
else
  plan("clean") = matlab.buildtool.tasks.CleanTask;

  [compiler_id, compiler_opt] = get_compiler_options();

  for s = get_mex_sources()
    src = s{1};
    [~, name] = fileparts(src(1));

    plan("mex:" + name) = matlab.buildtool.tasks.MexTask(src, bindir, ...
      Options=[compiler_id, compiler_opt]);
  end
end

plan("mex").Description = "MEX build";

end


function legacyMexTask(bindir)

[compiler_id, compiler_opt] = get_compiler_options();

srcs = get_mex_sources();

%% build C++ mex
% https://www.mathworks.com/help/matlab/ref/mex.html
for s = srcs
  src = s{1};
  [~, name] = fileparts(src(1));
  disp("Building MEX target: " + name)
  mex(s{1}{:}, "-outdir", bindir, compiler_id, compiler_opt)
end
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


function srcs = get_mex_sources()

limits = "src/limits_fs.cpp";

win = limits;
if ispc
win(end+1) = "src/windows.cpp";
end

mac = "src/macos.cpp";

sym = "src/symlink_fs.cpp";


srcs = {
["src/is_admin.cpp", "src/admin_fs.cpp"] ...
"src/is_char_device.cpp", ...
"src/set_permissions.cpp", ...
["src/is_rosetta.cpp", mac], ...
["src/windows_shortname.cpp", win], ...
};

%%  new in R2024b
if isMATLABReleaseOlderThan("R2024b")
srcs{end+1} = ["src/is_symlink.cpp", win, sym];
srcs{end+1} = ["src/create_symlink.cpp", win, sym];
srcs{end+1} = ["src/read_symlink.cpp", win, sym];
end

end


function [compiler_id, compiler_opt] = get_compiler_options()

cxx = mex.getCompilerConfigurations('c++');
flags = cxx.Details.CompilerFlags;

msvc = startsWith(cxx.ShortName, "MSVCPP");

std = "-std=c++17";
compiler_id = "";
% FIXME: Windows oneAPI
if msvc
  std = "/std:c++17";
elseif ismac
  % keep for if-logic
elseif isunix && cxx.ShortName == "g++"
  % FIXME: update when desired GCC != 10 for newer Matlab
  if isMATLABReleaseOlderThan("R2025b") && ~startsWith(cxx.Version, "10")
    % https://www.mathworks.com/help/matlab/matlab_external/choose-c-or-c-compilers.html
    % https://www.mathworks.com/help/matlab/matlab_external/change-default-gcc-compiler-on-linux-system.html
    [s, ~] = system("which g++-10");
    if s == 0
      compiler_id = "CXX=g++-10";
    else
      warning("GCC 10 not found, using default GCC " + cxx.Version + " may fail on runtime")
    end
  end
end

opt = flags + " " + std;
if msvc
  compiler_opt = "COMPFLAGS=" + opt;
else
  compiler_opt = "CXXFLAGS=" + opt;
end

end
