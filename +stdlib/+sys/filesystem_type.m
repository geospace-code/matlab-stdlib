function [t, cmd] = filesystem_type(p)

t = '';

if ispc()
  dl = extractBefore(stdlib.absolute(p), 2);
  cmd = sprintf('pwsh -c "(Get-Volume -DriveLetter ''%s'').FileSystem"', dl);
elseif ismac()
  cmd = sprintf('df -aHY "%s" | awk ''NR==2 {print $2}''', p);
else
  cmd = sprintf('df --output=fstype "%s" | tail -n 1', p);
end

if stdlib.exists(p)
  [s, t] = system(cmd);
  if s == 0
    t = strip(t);
  end
end

end
