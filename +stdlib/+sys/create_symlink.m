
function ok = create_symlink(target, link)

ok = false;

if strlength(target) == 0 || strlength(link) == 0
  return
end

if ispc
  cmd = sprintf('pwsh -c "New-Item -ItemType SymbolicLink -Path "%s" -Target "%s""', link, target);
else
  cmd = sprintf('ln -s "%s" "%s"', target, link);
end

% suppress output text on powershell
[stat, ~] = system(cmd);

ok = stat == 0;

end
