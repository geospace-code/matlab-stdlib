function i = inode(p)

try
  i = int64(py.os.stat(p).st_ino);
  % int64 first is for Matlab <= R2022a
catch e
  warning(e.identifier, "%s", e.message)
  i = [];
end

i = uint64(i);
end
