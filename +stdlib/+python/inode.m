function i = inode(p)

try
  i = uint64(int64(py.os.stat(p).st_ino)); 
  % int64 first is for Matlab <= R2022a
catch e
  warning(e.identifier, "%s", e.message)
  i = [];
end
