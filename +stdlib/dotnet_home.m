%% DOTNET_HOME give .NET RuntimeLocation

function h = dotnet_home()
try
  h = dotnetenv().RuntimeLocation;
catch
  h = "";
end
end
