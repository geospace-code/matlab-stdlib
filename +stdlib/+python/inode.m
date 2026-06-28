function i = inode(file)

if stdlib.has_python()
  i = py.os.stat(file).st_ino;
  % Matlab <= R2022a wants int64 before uint64, but this can make OverflowError on Windows within Python
  % because on Windows st_dev is a 64-bit unsigned integer
  i = uint64(i);
else
  i = missing;
end

end
