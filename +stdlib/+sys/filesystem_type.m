function t = filesystem_type(p)

if ispc()
  dl = extractBefore(stdlib.absolute(p), 2);
  cmd = "pwsh -c (Get-Volume -DriveLetter " + dl + ").FileSystem";
elseif ismac()
  cmd = "df -aHY " + p + " | awk 'NR==2 {print $2}'";
else
  cmd = "df -T " + p + " | awk 'NR==2 {print $2}'";
end

[s, t] = system(cmd);
if s == 0
  t = strip(t);
else
  t = "";
end

end
