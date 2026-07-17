%% DOTNET.UPTIME get system uptime
% .NET >= 5

function t = uptime()
% https://learn.microsoft.com/en-us/dotnet/api/system.environment.tickcount64
tms = System.Environment.TickCount64;
ts = System.TimeSpan.FromMilliseconds(tms);
t = ts.TotalSeconds;

end
