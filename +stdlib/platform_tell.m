%% PLATFORM_TELL - Display information about the platform and environment

function json = platform_tell()

try
  r = matlabRelease().Release;
catch
  r = "R" + version('-release');
end

raw = struct("matlab_release", r, ...
"matlab_arch", computer('arch'), ...
"cpu_arch", stdlib.cpu_arch(), ...
"hdf5", stdlib.h5get_version(), ...
"netcdf", stdlib.nc_get_version());

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

  if ~isempty(co)
    raw.("compiler_" + lang) = co.ShortName;
    raw.("compiler_" + lang + "_version") = co.Version;
  end
end

try
  json = jsonencode(raw, "PrettyPrint", true);
catch e
  if e.identifier ~= "MATLAB:json:UnmatchedParameter"
    rethrow(e)
  end

  json = jsonencode(raw);
end

end
