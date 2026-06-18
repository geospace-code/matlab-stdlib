%% SUFFIX last suffix of filename

function s = suffix(p)
arguments
  p {mustBeTextScalar}
end

[~, n, s] = fileparts(p);

if stdlib.strempty(n)
  s = n;
end

end
