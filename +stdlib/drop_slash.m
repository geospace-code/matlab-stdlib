%% DROP_SLASH drop repeated and trailing slash
%

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

end
