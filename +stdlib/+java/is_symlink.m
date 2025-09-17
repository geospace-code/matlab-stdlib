function y = is_symlink(file)

if stdlib.strempty(file)
  y = false;
  return
end

try
  p = javaAbsolutePath(file);
  y = javaMethod('isSymbolicLink', 'java.nio.file.Files', p);
catch e
  javaException(e)
  y = logical([]);
end

end
