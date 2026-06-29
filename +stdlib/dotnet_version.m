%% DOTNET_VERSION version string for .NET Framework or .NET Core
% Windows has long had .NET installed from the factory.
% .NET is also available on Linux and macOS for Matlab if present on the system.

function v = dotnet_version()

v = stdlib.dotnet.version();

end
