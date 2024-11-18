function yes = is_subdir(subdir, dir)
%% IS_SUBDIR is subdir a subdirectory of dir?
arguments
  subdir (1,1) string
  dir (1,1) string
end

r = stdlib.relative_to(dir, subdir);

yes = strlength(r) > 0 && r ~= "." && ~startsWith(r, "..");

end
