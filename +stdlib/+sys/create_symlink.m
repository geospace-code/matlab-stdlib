function [ok, cmd, m] = create_symlink(target, link)

ok = false;
m = '';

if ispc()
  cmd = sprintf('pwsh -c "New-Item -ItemType SymbolicLink -Path ''%s'' -Target ''%s''"', link, target);
else
  cmd = sprintf('ln -s "%s" "%s"', target, link);
end

if stdlib.exists(target) && ~stdlib.strempty(link) && ~stdlib.exists(link)
  [stat, m] = system(cmd);
  ok = stat == 0;
end

end
