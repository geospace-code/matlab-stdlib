function plan = buildfile
plan = buildplan(localfunctions);

plan.DefaultTasks = "test";

pkg_name = "+stdlib";

if ~isMATLABReleaseOlderThan("R2023b")
  plan("check") = matlab.buildtool.tasks.CodeIssuesTask(pkg_name, IncludeSubfolders=true);
end

if ~isMATLABReleaseOlderThan("R2024b")

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

  root = plan.RootFolder;
  bindir = fullfile(root, pkg_name);

  plan("clean") = matlab.buildtool.tasks.CleanTask;

  plan("mex:is_char_device_mex") = matlab.buildtool.tasks.MexTask("src/is_char_device.cpp", bindir, ...
    Options=[compiler_id, compiler_opt]);

  is_symlink_src = ["src/is_symlink.cpp"];
  if ispc
    is_symlink_src(end+1) = "src/windows.cpp";
  end

  plan("mex:is_symlink_mex") = matlab.buildtool.tasks.MexTask(is_symlink_src, bindir, ...
    Options=[compiler_id, compiler_opt]);

  plan("test").Dependencies = "mex";
end

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
