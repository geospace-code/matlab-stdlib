function p = stem(path)
% STEM filename without directory or suffix
arguments
  path string
end

p = stdlib.fileio.stem(path);

end
