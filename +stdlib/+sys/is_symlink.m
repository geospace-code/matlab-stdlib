function [ok, cmd] = is_symlink(file)
arguments
  file (1,1) string
end

ok = false;

if ispc()
  cmd = sprintf('pwsh -command "(Get-Item -Path ''%s'').Attributes"', file);
else
  cmd = sprintf('test -L "%s"', file);
end

if strlength(file)
  [s, m] = system(cmd);
  ok = s == 0;

  if ispc()
    ok = ok && contains(m, 'ReparsePoint');
  end
end

end
