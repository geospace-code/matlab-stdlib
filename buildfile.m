function plan = buildfile
assert(~isMATLABReleaseOlderThan("R2023a"), "MATLAB R2023a or newer is required for this buildfile")

plan = buildplan(localfunctions);

pkg_name = "+stdlib";

addpath(plan.RootFolder)

%% Self-test setup
if isMATLABReleaseOlderThan("R2023b")
  plan("test") = matlab.buildtool.Task(Actions=@legacy_test);
elseif isMATLABReleaseOlderThan("R2024a")
  plan("test") = matlab.buildtool.tasks.TestTask("test", Strict=false);
else
  % can't use SourceFiles= if "mex" Task was run, even if plan("test").DisableIncremental = true;
  % this means incremental tests can't be used with MEX files (as of R2024b)
  plan("test") = matlab.buildtool.tasks.TestTask("test", Strict=false, TestResults="TestResults.xml");
end

td = plan.RootFolder + "/test";
srcs = [td+"/stdout_stderr_c.c", td+"/stdin_cpp.cpp", td+"/printenv.cpp", td+"/sleep.cpp"];
exes = [td+"/stdout_stderr_c.exe", td+"/stdin_cpp.exe", td+"/printenv.exe", td+"/sleep.exe"];
if ~isempty(get_compiler("fortran"))
  srcs = [srcs, td + "/stdout_stderr_fortran.f90", td + "/stdin_fortran.f90"];
  exes = [exes, td+"/stdout_stderr_fortran.exe", td+"/stdin_fortran.exe"];
end
plan("exe") = matlab.buildtool.Task(Inputs=srcs, Outputs=exes, Actions=@build_exe);
plan("test").Dependencies = "exe";

if ~isMATLABReleaseOlderThan("R2023b")
  plan("clean") = matlab.buildtool.tasks.CleanTask;
end

if ~isMATLABReleaseOlderThan("R2024a")
  plan("check") = matlab.buildtool.tasks.CodeIssuesTask(pkg_name, IncludeSubfolders=true, ...
    WarningThreshold=0, Results="CodeIssues.sarif");

  plan("coverage") = matlab.buildtool.tasks.TestTask(Description="code coverage", Dependencies="clean", SourceFiles="test", Strict=false, CodeCoverageResults="code-coverage.xml");
end

%% MexTask
bindir = fullfile(plan.RootFolder, pkg_name);
[compiler_opt, linker_opt] = get_compiler_options();

use_legacy_mex = isMATLABReleaseOlderThan("R2024b");

if use_legacy_mex
  % dummy task to allow "buildtool mex" to build all MEX targets
  plan("mex") = matlab.buildtool.Task();
  mex_deps = string.empty;
end

for s = get_mex_sources()
  src = s{1};
  name = stdlib.stem(src(1));

  % name of MEX target function is name of first source file
  if use_legacy_mex
    mex_name = "mex_" + name;
    plan(mex_name) = matlab.buildtool.Task(Inputs=src, ...
      Outputs=fullfile(bindir, name + "." + mexext()), ...
      Actions=@(context) legacy_mex(context, compiler_opt, linker_opt), ...
      Description="Legacy MEX");
    mex_deps(end+1) = mex_name; %#ok<AGROW>
  else
    plan("mex:" + name) = matlab.buildtool.tasks.MexTask(src, bindir, ...
      Options=[compiler_opt, linker_opt]);
  end
end

if use_legacy_mex
  plan("mex").Dependencies = mex_deps;
end

end


function legacy_mex(context, compiler_opt, linker_opt)
bindir = fileparts(context.Task.Outputs.Path);
mex(context.Task.Inputs.Path, "-outdir", bindir, compiler_opt{:}, linker_opt)
end


function legacy_test(context)
r = runtests(context.Plan.RootFolder + "/test", Strict=false);
% Parallel Computing Toolbox takes more time to startup than is worth it for this task

assert(~isempty(r), "No tests were run")
assertSuccess(r)
end


function publishTask(context)
% publish HTML inline documentation strings to individual HTML files
outdir = context.Plan.RootFolder + "/docs";

publish_gen_index_html("stdlib", ...
  "A standard library of functions for Matlab.", ...
  "https://github.com/geospace-code/matlab-stdlib", ...
  outdir)
end


function build_exe(context)

for i = 1:length(context.Task.Inputs)
  src = context.Task.Inputs(i);
  exe = context.Task.Outputs(i).paths;
  exe = exe(1);

  ext = stdlib.suffix(src.paths);
  switch ext
    case ".c", lang = "c";
    case ".cpp", lang = "c++";
    case ".f90", lang = "fortran";
    otherwise, error("unknown code suffix " + ext)
  end

  [comp, shell, outFlag] = get_build_cmd(lang);
  if isempty(comp), return, end

  cmd = join([comp, src.paths, outFlag + exe]);
  if ~isempty(shell)
    cmd = join([shell, "&&", cmd]);
  end

  disp(cmd)
  system(cmd);
end

end


function [comp, shell] = get_compiler(lang)

lang = lower(lang);

co = mex.getCompilerConfigurations(lang);

if isempty(co)
  switch lang
    case "fortran"
      comp = getenv("FC");
      if isempty(comp)
        disp("set FC environment variable to the Fortran compiler path, or do 'mex -setup fortran'")
        if ismac()
          p = '/opt/homebrew/bin/';
          for fc = ["flang", "gfortran"]
            comp = stdlib.which(fc, p);
            if ~isempty(comp)
              % disp(lang + " compiler: " + comp)
              setenv("FC", comp);
              return
            end
          end
          disp("on macOS, environment variables propagate in to GUI programs like Matlab by using 'launchctl setenv FC' and a reboot. Or by using 'FC=gfortran matlab -batch buildtool exe'")
        end
      end
    case "c++"
      comp = getenv("CXX");
      if isempty(comp)
        disp("set CXX environment variable to the C++ compiler path, or do 'mex -setup c++")
      end
    case "c"
      comp = getenv("CC");
      if isempty(comp)
        disp("set CC environment variable to the C compiler path, or do 'mex -setup c'")
      end
    otherwise, error("language not known " + lang)
  end
else
  comp = co.Details.CompilerExecutable;
  % disp(lang + " compiler: " + co.ShortName + " " + co.Name + " " + co.Version + " " + comp)
end


shell = string.empty;
if ispc() && ~isempty(co)
  disp("Shell: " + co.Details.CommandLineShell)

  if startsWith(co.ShortName, ["INTEL", "MSVC"])
    shell = join([strcat('"',string(co.Details.CommandLineShell),'"'), ...
                co.Details.CommandLineShellArg], " ");
  end
end

end


function [comp, shell, outFlag] = get_build_cmd(lang)

[comp, shell] = get_compiler(lang);

if isempty(shell)
  outFlag = "-o";
else
  outFlag = "/Fo" + tempdir + " /link /out:";
end


end


function srcs = get_mex_sources(build_all)
arguments
  build_all (1,1) logical = false
end

pure = "src/pure.cpp";
normal = ["src/normalize_fs.cpp", pure];

win = [pure, "src/windows.cpp"];

mac = "src/macos.cpp";
linux = "src/linux_fs.cpp";

sym = "src/symlink_fs.cpp";


srcs = {
"src/is_absolute.cpp", ...
"src/unlink.cpp", ...
["src/is_admin.cpp", "src/admin_fs.cpp"] ...
"src/is_char_device.cpp", ...
["src/normalize.cpp", normal], ...
["src/parent.cpp", "src/parent_fs.cpp", normal], ...
"src/relative_to.cpp", ...
"src/proximate_to.cpp", ...
"src/disk_available.cpp", ...
"src/disk_capacity.cpp", ...
["src/is_wsl.cpp", linux], ...
"src/set_permissions.cpp", ...
["src/is_rosetta.cpp", mac], ...
["src/windows_shortname.cpp", win], ...
["src/drop_slash.cpp", normal], ...
};

if isMATLABReleaseOlderThan("R2024b") || build_all
srcs{end+1} = ["src/is_symlink.cpp", win, sym];
srcs{end+1} = ["src/read_symlink.cpp", win, sym];
end

if isMATLABReleaseOlderThan("R2024b") || build_all || ispc
% so that we dont't need to run matlab AsAdmin on Windows
srcs{end+1} = ["src/create_symlink.cpp", win, sym];
end

end


function [compiler_opt, linker_opt] = get_compiler_options()

cxx = mex.getCompilerConfigurations('c++');
flags = cxx.Details.CompilerFlags;

msvc = startsWith(cxx.ShortName, "MSVCPP");

std = "-std=c++17";
% mex() can't handle string.empty
compiler_id = "";
linker_opt = "";

% this override is mostly for CI. Ensure auto-compiler flags are still correct if using this.
cxxenv = getenv("CXXMEX");
if ~isempty(cxxenv)
  compiler_id = "CXX=" + cxxenv;
  disp("MEX compiler override: " + compiler_id)
end

if msvc
  std = "/std:c++17";
  % on Windows, Matlab doesn't register unsupported MSVC or oneAPI
elseif cxx.Name == "Xcode Clang++"
  if isMATLABReleaseOlderThan("R2023b") && stdlib.version_atleast(cxx.Version, "15.0")
    warning("Xcode Clang++ " + cxx.Version + " may not support this Matlab version")
  end
elseif ~strlength(compiler_id) && cxx.ShortName == "g++"
  if ~stdlib.version_atleast(cxx.Version, "8")
    warning("g++ 8 or newer is required for MEX, detected g++" + cxx.Version)
  end

  if ~stdlib.version_atleast(cxx.Version, "9")
    linker_opt = "-lstdc++fs";
  end
end

opt = flags + " " + std;
if msvc
  compiler_opt = "COMPFLAGS=" + opt;
else
  compiler_opt = "CXXFLAGS=" + opt;
end

if strlength(compiler_id)
  compiler_opt = [compiler_id, compiler_opt];
end

end
