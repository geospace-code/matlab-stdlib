function [os, vers] = os_version()

if ispc()
  cmd1 = 'pwsh -c "(Get-CimInstance -ClassName Win32_OperatingSystem).Caption"';
  cmd2 = 'pwsh -c "(Get-CimInstance -ClassName Win32_OperatingSystem).Version"';
else
  cmd1 = 'uname -s';
  cmd2 = 'uname -r';
end

[s, os] = system(cmd1);
if s == 0
  os = deblank(os);
else
  os = missing;
end

[s, vers] = system(cmd2);
if s == 0
  vers = deblank(vers);
else
  vers = missing;
end

end
