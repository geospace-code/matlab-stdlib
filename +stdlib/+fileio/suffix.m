function s = suffix(path)
% SUFFIX last suffix of filename
arguments
  path string
end

[~, ~, s] = fileparts(path);

end
