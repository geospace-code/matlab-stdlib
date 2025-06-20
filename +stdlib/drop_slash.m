%% DROP_SLASH drop repeated and trailing slash
% optional: mex
%
% on Windows, if leading double slash, do not drop

function d = drop_slash(p)
arguments
  p {mustBeTextScalar}
end

% drop repeated slashes inside string
d = regexprep(char(p), '/+', '/');

% drop trailing slash "/" or "\", but preserve a single slash if that's the only character
while strlength(d) > 1 && endsWith(d, {'/', '\'})
  d = d(1:end-1);
end

if ispc() && ~isempty(d) && strcmp(d, stdlib.root_name(p))
  d = strcat(d, '/');
end

if isstring(p)
  d = string(d);
end

end

%!assert(drop_slash(''), '')
%!assert(drop_slash('/'), '/')
%!assert(drop_slash('a//b'), 'a/b')
%!assert(drop_slash('a//b/'), 'a/b')
