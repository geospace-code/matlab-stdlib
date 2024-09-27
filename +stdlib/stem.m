function p = stem(path)
% STEM filename without directory or suffix
arguments
  path string
end

[~, p] = fileparts(path);

end
