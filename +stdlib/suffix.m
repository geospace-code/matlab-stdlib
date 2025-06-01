%% SUFFIX last suffix of filename

function s = suffix(p)
arguments
  p {mustBeTextScalar}
end

[~, ~, s] = fileparts(p);

end

%!assert (suffix('/a/b.c'), '.c')
