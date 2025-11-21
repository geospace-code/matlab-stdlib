function t = uptime()
% DOTNET.UPTIME get system uptime

try
  tms = System.Environment.TickCount64;
  ts = System.TimeSpan.FromMilliseconds(tms);
  t = ts.TotalSeconds;
catch e
  dotnetException(e)
  t = [];
end

end
