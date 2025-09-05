function y = is_symlink(file)

if stdlib.strempty(file)
  y = false;
  return
end

try
  y = java.nio.file.Files.isSymbolicLink(javaAbsolutePath(file));
catch e
  javaException(e)
  y = logical.empty;
end

end
