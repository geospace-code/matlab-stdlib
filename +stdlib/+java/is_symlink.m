function ok = is_symlink(file)

try
  ok = java.nio.file.Files.isSymbolicLink(javaAbsolutePath(file));
catch e
  javaException(e)
  ok = logical.empty;
end

end
