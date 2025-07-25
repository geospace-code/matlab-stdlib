%% PLATFORM_TELL - Display information about the platform and environment

function platform_tell()

r = matlabRelease();
fprintf('Matlab: %s %s %s\n', r.Release, computer('arch'), stdlib.cpu_arch());

fprintf('HDF5 %s\n', stdlib.h5get_version());
fprintf('netCDF %s\n', stdlib.nc_get_version());

if stdlib.has_java()
  fprintf('Java: %s %s  Home: %s\n', stdlib.java_vendor(), stdlib.java_version(), stdlib.java_home());
end

if stdlib.has_dotnet()
  fprintf('.NET: %s\n', stdlib.dotnet_version());
end

pv = stdlib.python_version();
if ~isempty(pv)
  fprintf('Python: %d.%d.%d  Home: %s\n', pv(1), pv(2), pv(3), stdlib.python_home());
end

if ismac()
  fprintf('Xcode CLT: %s\n', stdlib.xcode_version());
end

for lang = ["C", "C++", "Fortran"]
  co = mex.getCompilerConfigurations(lang);
  if ~isempty(co)
    fprintf('%s compiler: %s %s\n', lang, co.ShortName, co.Version)
  end
end

end
