%% DROP_SLASH drop repeated and trailing slash
%

function d = drop_slash(filepath)
arguments
  filepath string
end

s = stdlib.posix(filepath);

% drop repeated slashes inside string
d = regexprep(s, '/+', '/');

% drop all trailing slashes
i = ~strcmp(d, '/') & ~strcmp(d, stdlib.root(s));

d(i) = regexprep(d(i), '/$', '');

end
