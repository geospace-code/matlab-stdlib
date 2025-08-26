function [t, cmd] = disk_available(p)

t = [];

if ispc()
  cmd = sprintf('pwsh -c ([System.IO.DriveInfo]''%s'').AvailableFreeSpace', stdlib.absolute(p));
  % r = stdlib.root_name(stdlib.absolute(p));
  % cmd = sprintf('pwsh -c (Get-CimInstance -ClassName Win32_LogicalDisk -Filter \"DeviceID=''%s''\").FreeSpace', r);
  % slower
  % dl = extractBefore(stdlib.absolute(p), 2);
  % cmd = sprintf('pwsh -c "(Get-Volume -DriveLetter ''%s'').SizeRemaining"', dl);
  % slowest
elseif ismac()
  cmd = sprintf('df -k "%s" | awk ''NR==2 {print $4*1024}''', p);
else
  cmd = sprintf('df -B1 "%s" | awk ''NR==2 {print $4}''', p);
end

if stdlib.exists(p)
  [s, t] = system(cmd);
  if s == 0
    t = str2double(t);
  end
end

t = uint64(t);

end
