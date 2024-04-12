function ok = touch(p)
arguments
  p (1,1) string
end

ok = stdlib.fileio.touch(p);

end