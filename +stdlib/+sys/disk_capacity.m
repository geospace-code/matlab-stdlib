function t = disk_capacity(p)

t = uint64(0);

if ~stdlib.exists(p), return, end

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
  t = str2double(t);
end

t = uint64(t);

end
