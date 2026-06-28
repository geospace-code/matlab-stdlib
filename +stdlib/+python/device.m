function i = device(file)

if stdlib.has_python()
  i = uint64(py.os.stat(file).st_dev);
  % Matlab <= R2022a wants int64 before uint64, but this can make OverflowError on Windows within Python
  % because on Windows st_dev is a 64-bit unsigned integer
else
  i = missing;
end


end
