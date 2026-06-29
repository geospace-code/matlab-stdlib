%% DOTNET.UPTIME get system uptime

function t = uptime()

if stdlib.has_dotnet() && stdlib.dotnet.api() >= 5
  tms = System.Environment.TickCount64;
  ts = System.TimeSpan.FromMilliseconds(tms);
  t = ts.TotalSeconds;
else
  t = missing;
end

end
