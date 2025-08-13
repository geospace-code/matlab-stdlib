%% PLATFORM_TELL - Display information about the platform and environment
% designed to work back to R2016b

function json = platform_tell()

try
  r = matlabRelease().Release;
catch
  r = "R" + version('-release');
end

raw = struct('matlab_release', r, ...
'matlab_arch', computer('arch'), ...
'hdf5', stdlib.h5get_version(), ...
'netcdf', stdlib.nc_get_version());

if stdlib.has_java()
  raw.java_vendor = stdlib.java_vendor();
  raw.java_version = stdlib.java_version();
  raw.java_home = stdlib.java_home();
end

if stdlib.has_dotnet()
  raw.dotnet_version = stdlib.dotnet_version();
end

pv = stdlib.python_version();
if ~isempty(pv)
  raw.python_version = sprintf("%d.%d.%d",pv(1), pv(2), pv(3));
  raw.python_home = stdlib.python_home();
end

if ismac()
  raw.xcode_version = stdlib.xcode_version();
end

for lang = ["C", "Cpp", "Fortran"]
  co = mex.getCompilerConfigurations(lang);
  ct = ['compiler_' lang{1}];
  vt = ['compiler_' lang{1} '_version'];
  raw.(ct) = "";
  raw.(vt) = "";

  if ~isempty(co)
    raw.(ct) = co.ShortName;
    raw.(vt) = co.Version;
  end
end

try
  json = jsonencode(raw, "PrettyPrint", true);
catch e
  switch e.identifier
    case {'MATLAB:json:UnmatchedParameter', 'MATLAB:maxrhs'}
      json = jsonencode(raw);
    otherwise
      rethrow(e)
  end
end

end
