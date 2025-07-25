function t = disk_capacity(p)

if ispc()
  dl = extractBefore(stdlib.absolute(p), 2);
  cmd = "pwsh -c (Get-Volume -DriveLetter " + dl + ").Size";
elseif ismac()
  cmd = "df -k " + p + " | awk 'NR==2 {print $2*1024}'";
else
  cmd = "df -B1 " + p + " | awk 'NR==2 {print $2}'";
end

[s, t] = system(cmd);
if s == 0
  t = strip(t);
else
  t = "";
end

end
