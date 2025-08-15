function [ok, cmd] = is_symlink(p)

ok = false;

if ispc()
  cmd = sprintf('pwsh -command "(Get-Item -Path ''%s'').Attributes"', p);
else
  cmd = sprintf('test -L "%s"', p);
end

if strlength(p)
  [s, m] = system(cmd);
  ok = s == 0;

  if ispc()
    ok = ok && contains(m, 'ReparsePoint');
  end
end

end
