function [t, cmd] = disk_available(file)

if ispc()
  cmd = sprintf('pwsh -c ([System.IO.DriveInfo][System.IO.Path]::GetFullPath(''%s'')).AvailableFreeSpace', file);
  % r = stdlib.root_name(stdlib.absolute(file));
  % cmd = sprintf('pwsh -c (Get-CimInstance -ClassName Win32_LogicalDisk -Filter \"DeviceID=''%s''\").FreeSpace', r);
  % slower
  % dl = extractBefore(stdlib.absolute(file), 2);
  % cmd = sprintf('pwsh -c "(Get-Volume -DriveLetter ''%s'').SizeRemaining"', dl);
  % slowest
elseif ismac()
  cmd = sprintf('df -k "%s" | awk ''NR==2 {print $4*1024}''', file);
else
  cmd = sprintf('df -B1 "%s" | awk ''NR==2 {print $4}''', file);
end

[s, r] = system(cmd);
assert(s==0, "stdlib:shell:disk_available", "Failed to get available disk space for %s using %s: %s ", file, cmd, r);

t = uint64(str2double(r));

end
