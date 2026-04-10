%% DOCTOR - Display information about the platform and environment
% works back to very old Matlab (R2011b at least)
% inspired by "brew doctor" and "conda info"

function json = doctor()

raw = struct('matlab', []);
raw.matlab.arch = computer('arch');

if ~stdlib.isoctave()
  try
    r = matlabRelease().Release;
  catch
    r = ['R' version('-release')];
  end
  raw.matlab.release = r;

  m = stdlib.matlab_bin_path();
  raw.matlab.extern_bin = m.extern_bin;
  raw.matlab.root = m.root;
  raw.matlab.arch_bin = m.arch_bin;
  raw.matlab.bin = m.bin;
end

h5v = stdlib.h5get_version();
if ~isempty(h5v)
  raw.hdf5 = h5v;
end

ncv = stdlib.nc_get_version();
if ~isempty(ncv)
  raw.netcdf = ncv;
end

if stdlib.has_java()
  raw.java.vendor = stdlib.java_vendor();
  raw.java.version = stdlib.java_version();
  raw.java.home = stdlib.java_home();
end

if stdlib.has_dotnet()
  raw.dotnet.version = stdlib.dotnet_version();
end

if stdlib.has_perl()
  raw.perl.version = sprintf('%d.%d.%d', stdlib.perl_version());
  raw.perl.exe = stdlib.perl_exe();
end

if stdlib.has_python()
  raw.python.version = sprintf('%d.%d.%d', stdlib.python_version());
  raw.python.home = stdlib.python_home();
end

if ismac()
  raw.xcode.version = stdlib.xcode_version();
end

if ~stdlib.isoctave()

langs = {'C', 'Cpp', 'Fortran'};
for i = 1:length(langs)
  lang = langs{i};
  co = mex.getCompilerConfigurations(lang);
  raw.compiler.(lang).name = '';
  raw.compiler.(lang).version = '';

  if ~isempty(co)
    raw.compiler.(lang).name = co(1).Name;
    raw.compiler.(lang).version = co(1).Version;
  end
end

end


try
  json = jsonencode(raw, 'PrettyPrint', true);
catch e
  switch e.identifier
    case {'MATLAB:json:UnmatchedParameter', 'MATLAB:maxrhs'}
      json = jsonencode(raw);
    case 'MATLAB:UndefinedFunction'
      json = raw;
    otherwise
      rethrow(e)
  end
end

end
