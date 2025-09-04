function [r, cmd] = read_symlink(file)
arguments
  file (1,1) string
end

r = string.empty;

if isunix()
  cmd = sprintf('readlink -fn "%s"', file);
else
  cmd = sprintf('pwsh -c "(Get-Item -Path ''%s'').Target"', file);

  % cmd = sprintf('fsutil reparsepoint query "%s"', file);
  % worried if searching for "Tag value: Symbolic Link" might be locale dependent
end

if stdlib.sys.is_symlink(file)
  [s, m] = system(cmd);
  if s == 0
    m = strip(string(m));
    if strlength(m) > 0
      r = m;
    end
  end
end

end
