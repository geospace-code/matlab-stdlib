%% DROP_SLASH drop repeated and trailing slash

function d = drop_slash(p)
arguments
  p (1,1) string
end

s = stdlib.posix(p);

% drop repeated slashes inside string
d = regexprep(s, "/+", "/");

if d == "/"
  return;
end

if ~ispc || (strlength(d) ~= 3 || d ~= stdlib.root(s))
  d = strip(d, "right", "/");
end

end
