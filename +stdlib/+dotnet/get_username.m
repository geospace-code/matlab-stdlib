function n = get_username()
% DOTNET.GET_USERNAME get the login name
%
% Ref: https://learn.microsoft.com/en-us/dotnet/api/system.environment.username

try
  n = char(System.Environment.UserName);
catch e
  dotnetException(e)
  n = '';
end

end
