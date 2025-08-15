function i = inode(file)
arguments
  file (1,1) string
end

try
  i = int64(py.os.stat(file).st_ino);
  % int64 first is for Matlab <= R2022a
catch
  i = [];
end

i = uint64(i);
end
