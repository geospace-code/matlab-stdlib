function yes = is_subdir(subdir, dir)
arguments
  subdir (1,1) string
  dir (1,1) string
end

r = stdlib.relative_to(dir, subdir);

yes = strlength(r) > 0 && r ~= "." && ~startsWith(r, "..");

end
