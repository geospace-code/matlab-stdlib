function y = is_symlink(file)

y = java.nio.file.Files.isSymbolicLink(javaAbsolutePath(file));

end
