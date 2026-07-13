function [r, cmd] = read_symlink(file)

if isunix()
  cmd = sprintf('readlink -fn "%s"', file);
else
  cmd = sprintf('pwsh -c "(Get-Item -Path ''%s'').Target"', file);

  % cmd = sprintf('fsutil reparsepoint query "%s"', file);
  % worried if searching for "Tag value: Symbolic Link" might be locale dependent
end

[s, m] = system(cmd);
assert(s == 0, 'stdlib:shell:read_symlink', 'Error executing read_symlink(%s) command %s: %s', file, cmd, m);

r = string(deblank(m));

end
