function comp = find_compiler(lang)
arguments (Output)
  comp string
end

co = mex.getCompilerConfigurations(lang);

if ~isempty(co)
  comp = co.Details.CompilerExecutable;
  return
end

if ismac()
  p = '/opt/homebrew/bin/';
  disp("on macOS, environment variables propagate in to GUI programs like Matlab by using 'launchctl setenv FC' and a reboot.")
elseif ispc()
  p = getenv('CMPLR_ROOT');
  if isempty(p)
    p = getenv("MW_MINGW64_LOC");
  end
  if isempty(p)
    p = getenv("MINGWROOT");
  end
  if ~endsWith(p, ["bin", "bin/"])
    p = p + "/bin";
  end
else
  p = '';
end

comp = string.empty;

switch lang
  case "c", names = ["clang", "gcc", "icx"];
  case "c++", names = ["clang++", "g++", "icpx"];
  case "fortran", names = ["flang", "gfortran", "ifx"];
  otherwise, error('Unsupported language: %s', lang)
end

for fc = names
  comp = stdlib.which(fc, p);
  if ~isempty(comp)
    return
  end
end

end
