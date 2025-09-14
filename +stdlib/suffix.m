%% SUFFIX last suffix of filename

function s = suffix(p)

[~, n, s] = fileparts(p);

if stdlib.strempty(n)
  s = n;
end

end
