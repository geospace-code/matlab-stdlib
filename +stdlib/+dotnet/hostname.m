function n = hostname()
% DOTNET.HOSTNAME get the computer network hostname
%
% alternative for machine name:
% n = char(System.Environment.MachineName);
% https://learn.microsoft.com/en-us/dotnet/api/system.environment.machinename

try
  n = char(System.Net.Dns.GetHostName());
catch e
  dotnetException(e);
  n = '';
end

% https://learn.microsoft.com/en-us/dotnet/api/system.net.dns.gethostname

end
