function t = uptime()
% SYS.UPTIME Get system uptime in seconds.

t = [];

if ispc()
  [s, m] = system('pwsh -c "(Get-Uptime).TotalSeconds"');
elseif ismac()
  [s, m] = system('sysctl -n kern.boottime | awk ''{print $4}'' | sed ''s/,//g''');
else
  [s, m] = system('cat /proc/uptime | awk ''{print $1}''');
end

if s == 0
  t = str2double(m);
end

if ismac()
  t = posixtime(datetime('now', 'TimeZone', 'UTC')) - t;
end

end
