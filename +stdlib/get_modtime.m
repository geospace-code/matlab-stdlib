function t = get_modtime(p)
arguments
  p (1,1) string
end

t = stdlib.fileio.get_modtime(p);

end