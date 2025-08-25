function [y, cmd] = is_dev_drive(fpath)
arguments
  fpath (1,1) string
end

y = false;
cmd = '';


if ispc()
  cmd = sprintf('fsutil devdrv query ''%s''', fpath);
  [s, m] = system(cmd);
  if s == 0
    y = contains(m, ["This is a trusted developer volume", "this developer volume"]);
  else
    y = logical.empty;
  end
end
end
