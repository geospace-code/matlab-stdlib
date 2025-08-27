%% OS_VERSION Get operating system name and version.
%
% Note: for Windows 11, need new-enough Java version to show Windows 11
% instead of Windows 10.
%
%%% Outputs
% * os: operating system name
% * version: operating system version
% * b: backend used
%
% Ref: https://bugs.openjdk.org/browse/JDK-8274840

function [os, version, b] = os_version(backend)
arguments
  backend (1,:) string = ["sys", "python", "dotnet", "java"]
end

o = stdlib.Backend(mfilename(), backend);

[os, version] = o.func();
b = o.backend;

end
