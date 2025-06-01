%% DROP_SLASH drop repeated and trailing slash
% optional: mex
%
% on Windows, if leading double slash, do not drop

function d = drop_slash(p)
arguments
  p {mustBeTextScalar}
end

s = stdlib.posix(p);

uncslash = ispc && startsWith(s, '//');

% drop repeated slashes inside string
d = regexprep(s, '/+', '/');

L = strlength(d);

if L < 2
  if uncslash
    d = '//';
  end
elseif ~ispc || (L ~= 3 || ~strcmp(d, stdlib.root(s)))
  d = regexprep(d, '/$', '');
end

if uncslash
  d = strcat('/', d);
end

if isstring(p)
  d = string(d);
end

end

%!assert(drop_slash(''), '')
%!assert(drop_slash('/'), '/')
%!assert(drop_slash('a//b'), 'a/b')
%!assert(drop_slash('a//b/'), 'a/b')
