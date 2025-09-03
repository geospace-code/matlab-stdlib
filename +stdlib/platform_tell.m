%% PLATFORM_TELL - Display information about the platform and environment
% works back to very old Matlab (R2011b at least)

function json = platform_tell()

try
  r = matlabRelease().Release;
catch
  r = ['R' version('-release')];
end

raw = struct('matlab_release', r, ...
'matlab_arch', computer('arch'), ...
'hdf5', stdlib.h5get_version(), ...
'netcdf', stdlib.nc_get_version());

m = stdlib.matlab_bin_path();
raw.matlab_extern_bin = m.extern_bin;
raw.matlab_root = m.root;
raw.matlab_arch_bin = m.arch_bin;
raw.matlab_bin = m.bin;

if stdlib.has_java()
  raw.java_vendor = stdlib.java_vendor();
  raw.java_version = stdlib.java_version();
  raw.java_home = stdlib.java_home();
end

if stdlib.has_dotnet()
  raw.dotnet_version = stdlib.dotnet_version();
end

if stdlib.has_perl()
  raw.perl_version = sprintf('%d.%d.%d', stdlib.perl_version());
  raw.perl_exe = stdlib.perl_exe();
end

if stdlib.has_python()
  raw.python_version = sprintf('%d.%d.%d', stdlib.python_version());
  raw.python_home = stdlib.python_home();
end

if ismac()
  raw.xcode_version = stdlib.xcode_version();
end

langs = {'C', 'Cpp', 'Fortran'};
for i = 1:length(langs)
  lang = langs{i};
  co = mex.getCompilerConfigurations(lang);
  ct = ['compiler_' lang];
  vt = ['compiler_' lang '_version'];
  raw.(ct) = '';
  raw.(vt) = '';

  if ~isempty(co)
    raw.(ct) = co.Name;
    raw.(vt) = co.Version;
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
