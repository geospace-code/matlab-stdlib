%% SUFFIX last suffix of filename

function s = suffix(p)
arguments
  p string
end

[~, n, s] = fileparts(p);

if strempty(n)
  s = n;
end

end
