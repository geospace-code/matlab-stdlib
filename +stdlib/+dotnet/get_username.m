%% DOTNET.GET_USERNAME get the login name

function n = get_username()
% https://learn.microsoft.com/en-us/dotnet/api/system.environment.username

if stdlib.has_dotnet()
  n = char(System.Environment.UserName);
else
  n = missing;
end

end
