%% STEM filename without directory or suffix

function p = stem(path)
arguments
  path string
end

[~, p] = fileparts(path);

end
