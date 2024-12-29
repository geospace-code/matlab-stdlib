%% OS_VERSION Get operating system name and version.
%
% Note: for Windows 11, need new-enough Java version to show Windows 11
% instead of Windows 10.
% Ref: https://bugs.openjdk.org/browse/JDK-8274840

function [os, version] = os_version()

os = javaSystemProperty("os.name");
version = javaSystemProperty("os.version");

end
