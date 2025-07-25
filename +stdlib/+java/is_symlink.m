function ok = is_symlink(p)

ok = java.nio.file.Files.isSymbolicLink(javaPathObject(stdlib.absolute(p)));

end
