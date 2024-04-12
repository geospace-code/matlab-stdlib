function ok = touch(p)
arguments
  p (1,1) string
end

if stdlib.fileio.exists(p)
  ok = stdlib.fileio.set_modtime(p);
else
  ok = java.io.File(p).createNewFile();
end

end