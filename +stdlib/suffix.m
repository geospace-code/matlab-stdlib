%% SUFFIX last suffix of filename

function s = suffix(path)
arguments
  path string
end

[~, ~, s] = fileparts(path);

end
