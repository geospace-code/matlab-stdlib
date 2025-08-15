function [o, cmd] = get_owner(file)
arguments
  file (1,1) string
end

o = "";

if ispc()
  cmd = sprintf('pwsh -c "if($x=Get-Acl -Path ''%s'') {$x.Owner}"', file);
elseif ismac()
  cmd = sprintf('stat -f %%Su "%s"', file);
else
  cmd = sprintf('stat -c %%U "%s"', file);
end

if stdlib.exists(file)
  [s, m] = system(cmd);
  if s == 0
    o = string(strip(m));
  end
end

end
