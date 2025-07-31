function t = filesystem_type(p)

t = string.empty;

if ~stdlib.exists(p), return, end

if ispc()
  dl = extractBefore(stdlib.absolute(p), 2);
  cmd = "pwsh -c (Get-Volume -DriveLetter " + dl + ").FileSystem";
elseif ismac()
  cmd = "df -aHY " + p + " | awk 'NR==2 {print $2}'";
else
  cmd = "df --output=fstype " + p + " | tail -n 1";
end

[s, t] = system(cmd);
if s == 0
  t = string(strip(t));
end

end
