function t = disk_available(p)

t = uint64(0);

if ~stdlib.exists(p), return, end

if ispc()
  dl = extractBefore(stdlib.absolute(p), 2);
  cmd = "pwsh -c (Get-Volume -DriveLetter " + dl + ").SizeRemaining";
elseif ismac()
  cmd = "df -k " + p + " | awk 'NR==2 {print $4*1024}'";
else
  cmd = "df -B1 " + p + " | awk 'NR==2 {print $4}'";
end

[s, t] = system(cmd);
if s == 0
  t = uint64(str2double(t));
end

end
