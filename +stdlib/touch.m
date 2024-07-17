function ok = touch(p)
arguments
  p (1,1) string
end

if stdlib.exists(p)
  ok = stdlib.set_modtime(p);
else
  ok = java.io.File(p).createNewFile();
end

end
