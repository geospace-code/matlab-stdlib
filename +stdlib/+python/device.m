function i = device(file)

try
  i = int64(py.os.stat(file).st_dev);
  % int64 first is for Matlab <= R2022a
catch e
  if ~contains(e.message, "FileNotFoundError")
    warning(e.identifier, "device(%s) failed: %s", file, e.message)
  end
  i = [];
end

i = uint64(i);

end
