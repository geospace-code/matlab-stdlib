function p = filename(path)
% FILENAME filename (including suffix) without directory
arguments
  path string
end

% NOT https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getName()
% because by our definition, a trailing directory component is not part of the filename
% this is like C++17 filesystem::path::filename

[~, n, e] = fileparts(path);
p = n + e;

end
