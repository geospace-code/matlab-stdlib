%% IS_SUBDIR is subdir a subdirectory of dir?

function s = is_subdir(subdir, dir)
arguments
  subdir (1,1) string
  dir (1,1) string
end


if ischar(subdir)
  w = ~isempty(strfind(dir, "..")) || ~isempty(strfind(subdir, "..")); %#ok<STREMP,UNRCH>
  s = strfind(subdir, dir) == 1 && (length(subdir) > length(dir));
else
  w = contains(dir, "..") || contains(subdir, "..");
  s = startsWith(subdir, dir) && (strlength(subdir) > strlength(dir));
end

if ~strcmp(subdir, dir) && w
  warning("is_subdir: %s and/or %s is ambiguous input with '..'  consider using stdlib.canonical() first", subdir, dir)
end

end

%!assert(!is_subdir("/a/b", "/a/b"))
%!assert(!is_subdir("/a/b", "/a/b/c"))
%!assert(!is_subdir("/a/b", "/a/b/c/"))
%!assert(!is_subdir("/a/b", "d"))
%!assert(is_subdir("a/b", "a"))
%!assert(!is_subdir("a", "a/.c"))

% this is incorrect on Windows at least %assert(is_subdir("a/b", "a/b/.."))
