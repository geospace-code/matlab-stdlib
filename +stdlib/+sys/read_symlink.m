function [r, cmd] = read_symlink(p)

r = "";

if isunix()
  cmd = sprintf('readlink -fn "%s"', p);
else
  cmd = sprintf('pwsh -c "(Get-Item -Path ''%s'').Target"', p);
end

if stdlib.is_symlink(p)
  [s, m] = system(cmd);
  if s == 0
    m = strip(string(m));
    if strlength(m) > 0
      r = m;
    end
  end
end

end
