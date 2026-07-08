%% DOTNET.HOME give .NET RuntimeLocation

function h = home()

if stdlib.has_dotnet()
  h = dotnetenv().RuntimeLocation;
else
  h = missing;
end

end
