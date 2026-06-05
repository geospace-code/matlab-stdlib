function [y, cmd] = is_admin()

if ispc()
  cmd = 'pwsh -c "([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)"';
else
  cmd = 'id -u';
end

[s, r] = system(cmd);
if s ~= 0
  warning("stdlib:is_admin:RuntimeError", "Failed to execute command '%s': %s", cmd, r);
  y = logical([]);
  return
end

if ispc()
  y = startsWith(r, 'True');
else
  y = startsWith(r, '0');
end

end
