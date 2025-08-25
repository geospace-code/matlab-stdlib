function i = device(file)

try
  i = int64(py.os.stat(file).st_dev);
  % int64 first is for Matlab <= R2022a
catch
  i = [];
end

i = uint64(i);

end
