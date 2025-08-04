%% OS_VERSION Get operating system name and version.
%
% Note: for Windows 11, need new-enough Java version to show Windows 11
% instead of Windows 10.
% Ref: https://bugs.openjdk.org/browse/JDK-8274840

function [os, version] = os_version(backend)
arguments
  backend (1,:)string = ["sys", "python", "dotnet", "java"]
end

fun = hbackend(backend, "os_version");
[os, version] = fun();

end
