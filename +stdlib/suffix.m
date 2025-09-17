%% SUFFIX last suffix of filename

function s = suffix(p)

[~, n, s] = fileparts(p);

if stdlib.strempty(n)
  s = n;
end

end

%!assert (stdlib.suffix('a//d.cl.as'), '.as')