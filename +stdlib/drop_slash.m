%% DROP_SLASH drop repeated and trailing slash
% optional: mex
%
% on Windows, if leading double slash, do not drop

function d = drop_slash(p)
arguments
  p {mustBeTextScalar}
end

s = stdlib.posix(p);

% drop repeated slashes inside string
d = regexprep(s, '/+', '/');

% drop all trailing slashes
if ~strcmp(d, '/') && ~strcmp(d, stdlib.root(s))
  d = regexprep(d, '/$', '');
end

if isstring(p)
  d = string(d);
end

end

%!assert(drop_slash(''), '')
%!assert(drop_slash('/'), '/')
%!assert(drop_slash('a//b'), 'a/b')
%!assert(drop_slash('a//b/'), 'a/b')
