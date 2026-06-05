function [t, cmd] = disk_capacity(file)

t = [];

if ispc()
  cmd = sprintf('pwsh -c ([System.IO.DriveInfo][System.IO.Path]::GetFullPath(''%s'')).TotalSize', file);
  % dl = extractBefore(stdlib.absolute(file), 2);
  % cmd = sprintf('pwsh -c "(Get-Volume -DriveLetter ''%s'').Size"', dl);
  % slower
elseif ismac()
  cmd = sprintf('df -k "%s" | awk ''NR==2 {print $2*1024}''', file);
else
  cmd = sprintf('df -B1 "%s" | awk ''NR==2 {print $2}''', file);
end

if stdlib.exists(file)
  [s, t] = system(cmd);
  if s == 0
    t = str2double(t);
  end
end

t = uint64(t);

end
