%% DOTNET.GET_USERNAME get the login name

function n = get_username()
% https://learn.microsoft.com/en-us/dotnet/api/system.environment.username

n = string(System.Environment.UserName);

end
