%% DOTNET_VERSION version string

function v = dotnet_version()

vs = System.Environment.Version;

v = sprintf('%d.%d.%d', vs.Major, vs.Minor, vs.Build);

end
