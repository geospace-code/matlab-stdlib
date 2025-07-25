function t = disk_available(p)

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
  t = strip(t);
else
  t = "";
end

end
