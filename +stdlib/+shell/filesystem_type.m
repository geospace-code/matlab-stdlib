function [r, cmd] = filesystem_type(file)

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

[s, r] = system(cmd);
assert(s==0, "stdlib:shell:filesystem_type", "Failed to get filesystem type for %s using %s: %s ", file, cmd, r);

r = deblank(r);

end
