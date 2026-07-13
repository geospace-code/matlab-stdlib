function [y, cmd] = is_dev_drive(fpath)

if ispc()
  cmd = sprintf('fsutil devdrv query ''%s''', fpath);
  [s, m] = system(cmd);
  assert(s == 0, 'stdlib:shell:is_dev_drive', 'Failed to run command: %s: %s', cmd, m);

  y = contains(m, ["This is a trusted developer volume", "this developer volume"]);
else
  y = false;
  cmd = '';
end

end
