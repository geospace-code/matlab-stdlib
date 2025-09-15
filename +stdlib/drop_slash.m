%% DROP_SLASH drop repeated and trailing slash

function d = drop_slash(filepath)

s = stdlib.posix(filepath);

% drop repeated slashes inside string
d = regexprep(s, '/+', '/');

% drop all trailing slashes
if ~strcmp(d, '/') && ~strcmp(d, stdlib.root(s))
  d = regexprep(d, '/$', '');
end

end
