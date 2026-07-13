%% DOTNET.UPTIME get system uptime

function t = uptime()

tms = System.Environment.TickCount64;
ts = System.TimeSpan.FromMilliseconds(tms);
t = ts.TotalSeconds;

end
