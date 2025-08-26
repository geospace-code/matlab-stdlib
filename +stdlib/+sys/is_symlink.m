function [ok, cmd] = is_symlink(file)

if ispc()
  cmd = sprintf('fsutil reparsepoint query "%s"', file);
  % cmd = sprintf('pwsh -command "(Get-Item -Path ''%s'').Attributes"', file);
  % works (examine output for ReparsePoint) but is like 100x slower
else
  cmd = sprintf('test -L "%s"', file);
end

[s, ~] = system(cmd);
ok = s == 0;

end
