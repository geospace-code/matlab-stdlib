%% DROP_SLASH drop repeated and trailing slash
% optional: mex
%
% on Windows, if leading double slash, do not drop

function d = drop_slash(p)
arguments
  p (1,1) string
end

s = stdlib.posix(p);

uncslash = ispc && startsWith(s, "//");

% drop repeated slashes inside string
d = regexprep(s, "/+", "/");

L = stdlib.len(d);

if L < 2
  if uncslash
    d = "//";
  end
  return;
end

if ~ispc || (L ~= 3 || ~strcmp(d, stdlib.root(s)))
  if ischar(s)
    if d(end) == '/'
      d = d(1:end-1);
    end
  else
    d = strip(d, "right", "/");
  end
end

if uncslash
  d = strcat("/", d);
end

end

%!assert(drop_slash(''), '')
%!assert(drop_slash('/'), '/')
%!assert(drop_slash('a//b'), 'a/b')
%!assert(drop_slash('a//b/'), 'a/b')
