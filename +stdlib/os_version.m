%% OS_VERSION Get operating system name and version.
%
% Note: for Windows 11, need new-enough Java version to show Windows 11
% instead of Windows 10.
% Ref: https://bugs.openjdk.org/browse/JDK-8274840

function [os, version] = os_version()

if stdlib.has_dotnet()
  v = System.Environment.OSVersion.VersionString;
  % https://learn.microsoft.com/en-us/dotnet/api/system.operatingsystem.versionstring
  vs = split(string(v), ' ');
  version = vs(end);
  os = join(vs(1:end-1));
else
  os = javaMethod("getProperty", "java.lang.System", "os.name");
  version = javaMethod("getProperty", "java.lang.System", "os.version");
  os = string(os);
  version = string(version);
end

end
