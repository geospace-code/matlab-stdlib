function y = is_writable(p)

% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/Files.html#isWritable(java.nio.file.Path)
% java.nio.file.Files java is about 10x slower than fileattrib
% needs absolute()
% file = stdlib.absolute(file, "", false);
% ok = java.nio.file.Files.isWritable(javaPathObject(file));

y = javaFileObject(p).canWrite();
end
