%% DOTNET.HOME give .NET RuntimeLocation

function h = home()

h = dotnetenv().RuntimeLocation;

end
