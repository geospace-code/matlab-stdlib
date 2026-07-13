function [o, cmd] = get_owner(file)

if ispc()
  cmd = sprintf('pwsh -c "if($x=Get-Acl -Path ''%s'') {$x.Owner}"', file);
elseif ismac()
  cmd = sprintf('stat -f %%Su "%s"', file);
else
  cmd = sprintf('stat -c %%U "%s"', file);
end

% Windows needs exists() rather than just ~strempty()
[s, m] = system(cmd);
assert(s == 0, 'stdlib:shell:get_owner', 'Failed to get owner of file "%s": %s', file, m);

o = deblank(m);

end
