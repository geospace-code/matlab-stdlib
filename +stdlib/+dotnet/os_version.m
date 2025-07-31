function [os, version] = os_version()

v = System.Environment.OSVersion.VersionString;
% https://learn.microsoft.com/en-us/dotnet/api/system.operatingsystem.versionstring
vs = split(string(v), ' ');
version = vs(end);
os = join(vs(1:end-1));

end
