function p = filename(path)
% FILENAME filename (including suffix) without directory
arguments
  path string
end

[~, n, e] = fileparts(path);

p = n + e;

end
