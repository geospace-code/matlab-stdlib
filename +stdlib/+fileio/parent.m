function p = parent(path)
% PARENT parent directory of path
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getParent()
arguments
  path (1,1) string
end

jp = java.io.File(path).getParent();
if isempty(jp)
  jp = ".";
end

p = stdlib.fileio.posix(jp);

end
