function [t, cmd] = filesystem_type(file)

t = '';

if ispc()
  cmd = sprintf('pwsh -c ([System.IO.DriveInfo][System.IO.Path]::GetFullPath(''%s'')).DriveFormat', file);
  % dl = extractBefore(stdlib.absolute(file), 2);
  % cmd = sprintf('pwsh -c "(Get-Volume -DriveLetter ''%s'').FileSystem"', dl);
  % slower
elseif ismac()
  cmd = sprintf('df -aHY "%s" | awk ''NR==2 {print $2}''', file);
else
  cmd = sprintf('df --output=fstype "%s" | tail -n 1', file);
end

if stdlib.exists(file)
  [s, t] = system(cmd);
  if s == 0
    t = deblank(t);
  end
end

end
