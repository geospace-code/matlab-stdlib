function i = device(p)

try
  i = uint64(int64(py.os.stat(p).st_dev));
  % int64 first is for Matlab <= R2022a
catch e
  warning(e.identifier, "device(%s) failed: %s", p, e.message)
  i = [];
end

end
