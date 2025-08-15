function ok = is_symlink(file)
arguments
  file (1,1) string
end

ok = java.nio.file.Files.isSymbolicLink(javaPathObject(stdlib.absolute(file)));

end
