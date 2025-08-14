function i = disk_usage(file, v)

try
  u = py.shutil.disk_usage(file);
  switch v
    case 'total', i = u.total;
    case 'free', i = u.free;
    otherwise, error('stdlib:python:disk_usage:valueError', 'unknown disk_usage property %s', v)
  end

  i = int64(i);
  % int64 first is for Matlab <= R2022a
catch
  i = [];
end

i = uint64(i);
end
