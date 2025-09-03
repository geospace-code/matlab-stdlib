%% DOTNET.GET_HOSTNAME get the computer network hostname

function n = hostname()

%n = char(System.Environment.MachineName);
% https://learn.microsoft.com/en-us/dotnet/api/system.environment.machinename

n = char(System.Net.Dns.GetHostName());
% https://learn.microsoft.com/en-us/dotnet/api/system.net.dns.gethostname

end
