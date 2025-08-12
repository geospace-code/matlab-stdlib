%% IS_PREFIX is prefix a prefix of path?
% canonicalization and normalization are NOT performed
% duplicated slashes are dropped

function s = is_prefix(prefix, pth)

pr = stdlib.drop_slash(prefix);
p = stdlib.drop_slash(pth);

Lp = strlength(p);

s = Lp & startsWith(p, pr) & (Lp >= strlength(pr));

end
