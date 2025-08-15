function [o, cmd] = get_owner(p)

o = "";

if ispc()
  cmd = sprintf('pwsh -c "if($x=Get-Acl -Path ''%s'') {$x.Owner}"', p);
elseif ismac()
  cmd = sprintf('stat -f %%Su "%s"', p);
else
  cmd = sprintf('stat -c %%U "%s"', p);
end

if stdlib.exists(p)
  [s, m] = system(cmd);
  if s == 0
    o = string(strip(m));
  end
end

end
