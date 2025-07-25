function f = disk_available(d)

try
  di = py.shutil.disk_usage(d);
  f = int64(di.free);
  % int64 first is for Matlab <= R2022a
catch e
  warning(e.identifier, "disk_available(%s) failed: %s", d, e.message);
  f = [];
end

end
