function [os, version] = os_version()

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
  os = '';
end

[s, version] = system(cmd2);
if s == 0
  version = deblank(version);
else
  version = '';
end

end
