%% IS_SUBDIR is subdir a subdirectory of dir?
% canonicalization and normalization are NOT performed
% duplicated slashes are dropped

function s = is_subdir(subdir, dir)

s = stdlib.drop_slash(subdir);
d = stdlib.drop_slash(dir);

s = startsWith(s, d) & (strlength(s) > strlength(d));

end
