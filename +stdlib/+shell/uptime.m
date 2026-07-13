%% shell.UPTIME

function [t, cmd] = uptime()

if ispc()
  cmd = 'pwsh -c "(Get-Uptime).TotalSeconds"';
elseif ismac()
  cmd = 'sysctl -n kern.boottime | awk ''{print $4}'' | sed ''s/,//g''';
else
  cmd = 'cat /proc/uptime | awk ''{print $1}''';
end

[s, m] = system(cmd);
assert(s == 0, 'stdlib:shell:uptime', 'Error executing uptime command %s: %s', cmd, m);

t = str2double(m);

if ismac()
  t = posixtime(datetime('now', 'TimeZone', 'UTC')) - t;
end

end
