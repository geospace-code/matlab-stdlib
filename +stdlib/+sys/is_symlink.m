function ok = is_symlink(p)

ok = false;

if strlength(p) < 1, return, end

if ispc()
  [s, m] = system(sprintf('pwsh -command "(Get-Item -Path %s).Attributes"', p));
  ok = s == 0 && contains(m, 'ReparsePoint');
else
  [s, ~] = system(sprintf('test -L %s', p));
  ok = s == 0;
end

end
