%% SUFFIX last suffix of filename

function s = suffix(p)
arguments
  p string
end

[~, ~, s] = fileparts(p);

end
