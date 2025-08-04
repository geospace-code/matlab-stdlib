function o = get_owner(p)

o = '';
if ~stdlib.exists(p)
  return
end

if ispc()
  cmd = sprintf('pwsh -c "if($x=Get-Acl -Path ''%s'') {$x.Owner}"', p);
elseif ismac()
  cmd = sprintf('stat -f %%Su "%s"', p);
else
  cmd = sprintf('stat -c %%U "%s"', p);
end

[s, m] = system(cmd);
if s == 0
  o = strip(m);
end

end
