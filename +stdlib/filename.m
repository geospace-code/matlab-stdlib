function p = filename(path)
% FILENAME filename (including suffix) without directory
arguments
  path (1,1) string
end

p = stdlib.fileio.filename(path);

end