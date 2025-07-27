function i = inode(p)

i = [];

try
  i = int64(py.os.stat(p).st_ino);
  % int64 first is for Matlab <= R2022a
catch e
  if ~contains(e.message, "FileNotFoundError")
    warning(e.identifier, "inode(%s) failed: %s", p, e.message)
  end
end

i = uint64(i);
end
