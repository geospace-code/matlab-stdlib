%% DOTNET.HOSTNAME get the computer network hostname

function n = hostname()

%n = char(System.Environment.MachineName);
% https://learn.microsoft.com/en-us/dotnet/api/system.environment.machinename

if stdlib.has_dotnet()
  n = char(System.Net.Dns.GetHostName());
else
  n = missing;
end

% https://learn.microsoft.com/en-us/dotnet/api/system.net.dns.gethostname

end
