function i = device(file)

try
  i = uint64(py.os.stat(file).st_dev);
  % Matlab <= R2022a wants int64 before uint64, but this can make OverflowError on Windows within Python
  % because on Windows st_dev is a 64-bit unsigned integer
catch e
  i = pythonException(e);
end


end
