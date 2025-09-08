function [os, version] = os_version()

try
  v = System.Environment.OSVersion.VersionString;
  % https://learn.microsoft.com/en-us/dotnet/api/system.operatingsystem.versionstring
  vs = split(string(v), ' ');

  version = char(vs(end));
  os = char(join(vs(1:end-1)));
catch e
  dotnetException(e)
  os = '';
  version = '';
end

end
