function ok = set_modtime(p)
arguments
  p (1,1) string
end

ok = stdlib.fileio.set_modtime(p);

end