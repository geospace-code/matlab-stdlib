function f = disk_capacity(d)

try
  di = py.shutil.disk_usage(d);
  f = int64(di.total);
  % int64 first is for Matlab <= R2022a
catch e
  warning(e.identifier, "disk_capacity(%s) failed: %s", d, e.message);
  f = 0;
end

f = uint64(f);

end
