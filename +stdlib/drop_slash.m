%% DROP_SLASH drop repeated and trailing slash

function d = drop_slash(p)
arguments
  p (1,1) string
end

s = stdlib.posix(p);

% drop repeated slashes inside string
d = regexprep(s, "/+", "/");

L = stdlib.len(d);

if d == '/' || ~L
  return;
end

if ~ispc || (L ~= 3 || ~strcmp(d, stdlib.root(s, false)))
  if ischar(s)
    if d(end) == '/'
      d = d(1:end-1);
    end
  else
    d = strip(d, "right", "/");
  end
end

end

%!assert(drop_slash(''), '')
%!assert(drop_slash('/'), '/')
%!assert(drop_slash('//'), '/')
%!assert(drop_slash('a//b'), 'a/b')
%!assert(drop_slash('a//b/'), 'a/b')
