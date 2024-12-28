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

s = startsWith(p, pr) && (stdlib.len(p) >= stdlib.len(pr));

end

%!assert(is_prefix("a", "a"))
%!assert(is_prefix("a", "a/"))
%!assert(is_prefix("a", "a/b"))
%!assert(!is_prefix("a/b/c", "a/b"))
