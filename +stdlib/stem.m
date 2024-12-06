%% STEM filename without directory or suffix

function p = stem(p)
arguments
  p string
end

[~, p] = fileparts(p);

end
