function [os, vers] = os_version()

if ispc()
  cmd1 = 'pwsh -c "(Get-CimInstance -ClassName Win32_OperatingSystem).Caption"';
  cmd2 = 'pwsh -c "(Get-CimInstance -ClassName Win32_OperatingSystem).Version"';
else
  cmd1 = 'uname -s';
  cmd2 = 'uname -r';
end

[s, os] = system(cmd1);
assert(s == 0, 'stdlib:shell:os_version', 'Failed to run command: %s: %s', cmd1, os);

[s, vers] = system(cmd2);
assert(s == 0, 'stdlib:shell:os_version', 'Failed to run command: %s: %s', cmd2, vers);

os = deblank(os);
vers = deblank(vers);


end
