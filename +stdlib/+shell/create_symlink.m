
function [ok, cmd, m] = create_symlink(target, link)

if ispc()
  cmd = sprintf('pwsh -c "New-Item -ItemType SymbolicLink -Path ''%s'' -Target ''%s''"', link, target);
else
  cmd = sprintf('ln -s "%s" "%s"', target, link);
end

if stdlib.exists(target) && ~stdlib.exists(link)
  [stat, m] = system(cmd);
  ok = stat == 0;
else
  ok = false;
  m = '';
end

end
