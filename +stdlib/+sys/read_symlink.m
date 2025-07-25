function r = read_symlink(p)

r = string.empty;

if ~stdlib.is_symlink(p), return, end

if isunix()
  cmd = sprintf('readlink -fn %s', p);
else
  cmd = sprintf('pwsh -command "(Get-Item -Path %s).Target"', p);
end

[s, m] = system(cmd);
if s == 0
  m = strip(string(m));
  if strlength(m) > 0
    r = m;
  end
end

end
