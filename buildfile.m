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

cmex = HasTag("mex");

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
  plan("test_nomex") = matlab.buildtool.Task(Actions=@(context) legacy_test(context, cnomex), Dependencies="clean");
  plan("test_mex") = matlab.buildtool.Task(Actions=@(context) legacy_test(context, cmex), Dependencies="mex");

elseif isMATLABReleaseOlderThan("R2025a")
  % Matlab == R2024b
  plan("test:java")  = matlab.buildtool.Task(Actions=@(context) legacy_test(context, cjava));
  plan("test:exe")   = matlab.buildtool.tasks.TestTask(test_root, Tag="exe", Dependencies="exe");
  plan("test:nomex") = matlab.buildtool.Task(Actions=@(context) legacy_test(context, cnomex), Dependencies="clean");
  plan("test:mex")   = matlab.buildtool.Task(Actions=@(context) legacy_test(context, cmex), Dependencies="mex");

else
  % Matlab >= R2025a
  plan("test:exe")   = matlab.buildtool.tasks.TestTask(test_root, Tag="exe", Description="test subprocess",...
                         SourceFiles=[pkg_root, test_root + ["/*.cpp", "/*.c", "/*.f90"]], ...
                         RunOnlyImpactedTests=true,...
                         Dependencies="exe", TestResults="TestResults_exe.xml", Strict=true);

  plan("test:nomex") = matlab.buildtool.tasks.TestTask(test_root, Description="Test non-MEX targets",...
                         Selector=cnomex, ...
                         SourceFiles=pkg_root, RunOnlyImpactedTests=true,...
                         dependencies="clean_mex", TestResults="TestResults_nomex.xml", Strict=true);

  plan("test:mex")   = matlab.buildtool.tasks.TestTask(test_root, Description="Test mex targts",...
                         Selector=cmex, ...
                         SourceFiles=[pkg_root, plan.RootFolder + "/src"], RunOnlyImpactedTests=true,...
                         Dependencies="mex", TestResults="TestResults_mex.xml", Strict=true);

  plan("test:java") = matlab.buildtool.tasks.TestTask(test_root, Description="test Java targets", ...
                         Selector=cjava, ...
                         SourceFiles=pkg_root, RunOnlyImpactedTests=true,...
                         TestResults="TestResults_java.xml", Strict=true);

  plan("test:python") = matlab.buildtool.tasks.TestTask(test_root, Description="test Python targets", ...
                         Tag="python", ...
                         SourceFiles=pkg_root, RunOnlyImpactedTests=true,...
                         TestResults="TestResults_python.xml", Strict=true);
 
  addons = matlab.addons.installedAddons;
  if contains(addons.Name, "Matlab Test")
    plan("coverage") = matlab.buildtool.tasks.TestTask(test_root, ...
    Description="code coverage", ...
    Dependencies=["clean_mex", "exe"], ...
    SourceFiles=pkg_root, ...
    Selector=cnomex | HasTag("java") | HasTag("exe") | HasTag("python"), ...
    Strict=false).addCodeCoverage(matlabtest.plugins.codecoverage.StandaloneReport("coverage-report.html"));
  end

  plan("clean_mex") = matlab.buildtool.Task(Actions=@clean_mex, Description="Clean only MEX files to enable incremental tests");
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

if isMATLABReleaseOlderThan("R2024b"), return, end

%% MexTask
[compiler_opt, linker_opt] = get_compiler_options();

for s = get_mex_sources()
  src = s{1};
  name = stdlib.stem(src(1));

% name of MEX target function is name of first source file
  plan("mex:" + name) = matlab.buildtool.tasks.MexTask(src, pkg_root, ...
    Description="Build MEX target " + name, ...
    Options=[compiler_opt, linker_opt]);
end

end


function clean_mex(context)
run(context.Plan, "clean", {"mex"});
end


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
  if isempty(comp)
    return
  end
  if i == 1 && ~isempty(shell)
    disp("Shell: " + shell)
  end

  cmd = join([comp, src.paths, outFlag + exe]);
  if ~isempty(shell)
    cmd = join([shell, "&&", cmd]);
  end

  disp(cmd)
  [s, msg] = system(cmd);
  assert(s == 0, "Error %d: %s", s, msg)
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
        comp = get_fortran_compiler();
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
if ispc()
  if isempty(co)
    if any(contains(comp, ["gcc", "g++", "gfortran"]))
      shell = "set PATH=" + fileparts(comp) + pathsep + "%PATH%";
    end
  else
    if startsWith(co.ShortName, ["INTEL", "MSVC"])
      shell = join([strcat('"',string(co.Details.CommandLineShell),'"'), ...
                  co.Details.CommandLineShellArg], " ");
    elseif startsWith(co.ShortName, "mingw64")
      shell = "set PATH=" + fileparts(comp) + pathsep + "%PATH%";
    end
  end
end

end


function [comp, shell, outFlag] = get_build_cmd(lang)

[comp, shell] = get_compiler(lang);

if contains(shell, "Visual Studio") || contains(comp, "ifx.exe")
  outFlag = "/Fo" + tempdir + " /link /out:";
else
  outFlag = "-o";
end

end


function srcs = get_mex_sources(build_all)
arguments
  build_all (1,1) logical = false
end

srcs = {
"src/remove.cpp", ...
["src/normalize.cpp", "src/normalize_fs.cpp", "src/pure.cpp"], ...
"src/set_permissions.cpp"
};

if ~stdlib.has_python() || build_all
srcs{end+1} = "src/is_char_device.cpp";
srcs{end+1} = ["src/is_admin.cpp", "src/admin_fs.cpp"];
srcs{end+1} = "src/disk_available.cpp";
srcs{end+1} = "src/disk_capacity.cpp";
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


function comp = get_fortran_compiler()

disp("set FC environment variable to the Fortran compiler path, or do 'mex -setup fortran'")

if ismac()
  p = '/opt/homebrew/bin/';
  disp("on macOS, environment variables propagate in to GUI programs like Matlab by using 'launchctl setenv FC' and a reboot.")
  disp("if having trouble, try:")
  disp("  FC=gfortran matlab -batch 'buildtool exe'")
elseif ispc()
  p = getenv('CMPLR_ROOT');
  if isempty(p)
    p = getenv("MW_MINGW64_LOC");
  end
  if ~isempty(p) && ~endsWith(p, ["bin", "bin/"])
    p = p + "/bin";
  end
else
  p = '';
end

for fc = ["flang", "gfortran", "ifx"]
  comp = stdlib.which(fc, p);
  if ~isempty(comp)
    % disp(lang + " compiler: " + comp)
    setenv("FC", comp);
    return
  end
end

end
