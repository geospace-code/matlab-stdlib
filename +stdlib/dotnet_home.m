%% DOTNET_HOME give .NET RuntimeLocation

function h = dotnet_home()

h = string.empty;

try %#ok<TRYNC>

  if NET.isNETSupported
    % need to call this at least once or dotnetenv() is empty

    h = dotnetenv().RuntimeLocation;
  end

end

end
