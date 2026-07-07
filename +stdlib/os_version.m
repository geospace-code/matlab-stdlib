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
  backend (1,:) string {mustBeNonempty} = ["shell", "python", "dotnet", "java"];
end

os = missing;
version = missing;

for b = filterBackend(backend)
  f = str2func("stdlib." + b + ".os_version");
  [os, version] = f();

  if ~any(ismissing(os)) && ~any(ismissing(version))
    return
  end
end

end
