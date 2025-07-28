%% DOTNET.GET_HOSTNAME get the computer network hostname
% not necessary FQDN

function n = get_hostname()

n = string(System.Environment.MachineName);
% https://learn.microsoft.com/en-us/dotnet/api/system.environment.machinename

end
