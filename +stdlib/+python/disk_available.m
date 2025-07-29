function f = disk_available(p)

f = uint64(0);

if ~stdlib.exists(p), return, end

try
  di = py.shutil.disk_usage(p);
  f = uint64(int64(di.free));
  % int64 first is for Matlab <= R2022a
catch e
  warning(e.identifier, "disk_available(%s) failed: %s", p, e.message);
end

end
