%% DOTNET.VERSION version string

function v = version()

try
  vs = System.Environment.Version;
  v = sprintf('%d.%d.%d', vs.Major, vs.Minor, vs.Build);
catch e
  v = dotnetException(e);
end

end
