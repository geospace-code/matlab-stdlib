function [os, version] = os_version()

if stdlib.has_dotnet()
  v = System.Environment.OSVersion.VersionString;
  % https://learn.microsoft.com/en-us/dotnet/api/system.operatingsystem.versionstring
  vs = split(string(v), ' ');

  version = char(vs(end));
  os = char(join(vs(1:end-1)));
else
  os = missing;
  version = missing;
end

end
