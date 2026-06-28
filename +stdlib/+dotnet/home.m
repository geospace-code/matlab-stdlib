%% DOTNET.HOME give .NET RuntimeLocation

function h = home()

h = string.empty;

try %#ok<TRYNC>

  if NET.isNETSupported
    % need to call this at least once or dotnetenv() is empty

    h = dotnetenv().RuntimeLocation;
  end

end

end
