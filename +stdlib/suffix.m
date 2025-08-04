%% SUFFIX last suffix of filename

function s = suffix(p)
arguments
  p string
end

[~, n, s] = fileparts(p);

i = stdlib.strempty(n);
s(i) = n(i);

end
