function v = dotnet_api()
% DOTNET_API major version integer .NET

try
  v = System.Environment.Version.Major;
catch
  % not empty because that breaks less-than logic
  v = -1;
end

end
