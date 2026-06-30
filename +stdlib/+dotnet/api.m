%% DOTNET.API major version integer .NET

function v = api()

if stdlib.has_dotnet()
  v = System.Environment.Version.Major;
else
  % not empty or missing because that breaks less-than logic
  v = -1;
end

end
