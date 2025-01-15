function ok = is_symlink(p)
% must be absolute path
% NOT .canonical or symlink is gobbled!
p = stdlib.absolute(p, "", false);
op = javaPathObject(p);

% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#isSymbolicLink(java.nio.file.Path)
% https://dev.java/learn/java-io/file-system/links/

ok = java.nio.file.Files.isSymbolicLink(op);

end
