%% IS_PREFIX is prefix a prefix of path?
% canonicalization and normalization are NOT performed
% duplicated slashes are dropped

function s = is_prefix(prefix, pth)
arguments
  prefix (1,1) string
  pth (1,1) string
end

pr = stdlib.drop_slash(prefix);
p = stdlib.drop_slash(pth);

if ischar(pr)
  w = ~isempty(strfind(p, "..")) || ~isempty(strfind(pr, "..")); %#ok<STREMP>
  s = strfind(p, pr) == 1 && (length(p) >= length(pr));
else
  w = contains(p, "..") || contains(pr, "..");
  s = startsWith(p, pr) && (strlength(p) >= strlength(pr));
end

if ~strcmp(pr, p) && w
  warning("is_prefix: %s and/or %s is ambiguous input with '..'  consider using stdlib.canonical() first", pr, p)
end

end

%!assert(is_prefix("a", "a"))
%!assert(is_prefix("a", "a/"))
%!assert(is_prefix("a", "a/b"))
