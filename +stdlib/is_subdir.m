%% IS_SUBDIR is subdir a subdirectory of dir?
% canonicalization and normalization are NOT performed
% duplicated slashes are dropped

function s = is_subdir(subdir, dir)
arguments
  subdir (1,1) string
  dir (1,1) string
end

s = stdlib.drop_slash(subdir);
d = stdlib.drop_slash(dir);

s = startsWith(s, d) && (strlength(s) > strlength(d));

end

%!assert(!is_subdir("/a/b", "/a/b"))
%!assert(!is_subdir("/a/b", "/a/b/c"))
%!assert(!is_subdir("/a/b", "/a/b/c/"))
%!assert(!is_subdir("/a/b", "d"))
%!assert(is_subdir("a/b", "a"))
%!assert(!is_subdir("a", "a/.c"))
%!assert(!is_subdir("a/./b/c", "a/b"))

% this is incorrect on Windows at least %assert(is_subdir("a/b", "a/b/.."))
