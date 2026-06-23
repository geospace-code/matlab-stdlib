function [y, cmd] = is_dev_drive(fpath)

if ispc()
  cmd = sprintf('fsutil devdrv query ''%s''', fpath);
  [s, m] = system(cmd);
  if s == 0
    y = contains(m, ["This is a trusted developer volume", "this developer volume"]);
  else
    y = missing;
  end
else
  y = false;
  cmd = '';
end

end
