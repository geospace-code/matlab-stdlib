function f = disk_capacity(p)

f = uint64(0);

if ~stdlib.exists(p), return, end

try
  di = py.shutil.disk_usage(p);
  f = int64(di.total);
  % int64 first is for Matlab <= R2022a
catch e
  warning(e.identifier, "disk_capacity(%s) failed: %s", p, e.message);
end

f = uint64(f);

end
