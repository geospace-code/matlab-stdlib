function [y, cmd] = is_admin()

if ispc()
  cmd = 'pwsh -c "([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)"';
else
  cmd = 'id -u';
end

[s, r] = system(cmd);
assert(s == 0, 'stdlib:shell:is_admin', 'Failed to determine if user is admin %s: %s', cmd, r);

if ispc()
  y = startsWith(r, 'True');
else
  y = startsWith(r, '0');
end

end
