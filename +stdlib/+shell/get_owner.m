function [o, cmd] = get_owner(file)

o = '';

if ispc()
  cmd = sprintf('pwsh -c "if($x=Get-Acl -Path ''%s'') {$x.Owner}"', file);
elseif ismac()
  cmd = sprintf('stat -f %%Su "%s"', file);
else
  cmd = sprintf('stat -c %%U "%s"', file);
end

% Windows needs exists() rather than just ~strempty()
if stdlib.exists(file)
  [s, m] = system(cmd);
  if s == 0
    o = deblank(m);
  end
end

end
