%% DOTNET_HOME give .NET RuntimeLocation

function h = dotnet_home()

h = dotnetenv().RuntimeLocation;

end