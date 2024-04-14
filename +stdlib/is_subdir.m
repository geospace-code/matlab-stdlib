function yes = is_subdir(subdir, dir)
arguments
  subdir (1,1) string
  dir (1,1) string
end

yes = stdlib.fileio.is_subdir(subdir, dir);

end
