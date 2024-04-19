function isabs = is_absolute(apath)
arguments
  apath (1,1) string
end

isabs = stdlib.fileio.is_absolute(apath);

end
