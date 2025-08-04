function o = get_owner(p)

o = string.empty;
if ~stdlib.exists(p), return, end

if ispc()
  cmd = sprintf('pwsh -c (Get-Acl -Path "%s").Owner', p);
elseif ismac()
  cmd = sprintf('stat -f %%Su "%s"', p);
else
  cmd = sprintf('stat -c %%U "%s"', p);
end

[s, m] = system(cmd);
if s == 0
  o = string(strip(m));
end

end
