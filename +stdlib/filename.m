function p = filename(path)
% FILENAME filename (including suffix) without directory
arguments
  path string
end

p = stdlib.fileio.filename(path);

end