%% IS_SUBDIR is subdir a subdirectory of dir?

function s = is_subdir(subdir, dir)
arguments
  subdir (1,1) string
  dir (1,1) string
end

r = stdlib.relative_to(dir, subdir);

if stdlib.len(r) == 0 || r == "."
  s = false;
elseif ischar(r)
  s = ~strncmp(r, '..', 2);
else
  s = ~startsWith(r, "..");
end

end

%!assert(!is_subdir("/a/b", "/a/b"))
%!assert(!is_subdir("/a/b", "/a/b/c"))
%!assert(!is_subdir("/a/b", "/a/b/c/"))
%!assert(!is_subdir("/a/b", "d"))
%!assert(is_subdir("a/b", "a"))
%!assert(!is_subdir("a", "a/.c"))

% this is incorrect on Windows at least%assert(is_subdir("a/b", "a/b/.."))
