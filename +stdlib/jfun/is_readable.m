  % https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#isReadable(java.nio.file.Path)
  % java.nio.file.Files is about 10x slower than fileattrib
  % file = stdlib.absolute(file, "", false);
  % ok = java.nio.file.Files.isReadable(javaPathObject(file));
function y = is_readable(p)
y = javaFileObject(p).canRead();
end
