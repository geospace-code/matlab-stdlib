function t = filesystem_type(p)
arguments
  p (1,1) string
end

t = stdlib.fileio.filesystem_type(p);
end