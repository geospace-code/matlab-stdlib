function ok = is_symlink(file)

ok = java.nio.file.Files.isSymbolicLink(javaAbsolutePath(file));

end
