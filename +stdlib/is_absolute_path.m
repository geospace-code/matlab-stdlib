function isabs = is_absolute_path(p)
arguments
  p (1,1) string
end

isabs = stdlib.fileio.is_absolute(p);

end
