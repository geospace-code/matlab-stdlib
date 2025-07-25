function r = read_symlink(p)

r = string.empty;

if isunix()
  cmd = sprintf('readlink -fn %s', p);
else
  cmd = sprintf('pwsh -command "(Get-Item -Path %s).Target"', p);
end

[s, m] = system(cmd);
if s == 0
  r = strip(string(m));
end

end
