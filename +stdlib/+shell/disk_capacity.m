function [t, cmd] = disk_capacity(file)

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

[s, r] = system(cmd);
assert(s==0, "stdlib:shell:disk_capacity", "Failed to get total disk space for %s using %s: %s ", file, cmd, r);

t = uint64(str2double(r));

end
