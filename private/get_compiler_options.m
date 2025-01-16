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