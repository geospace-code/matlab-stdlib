function i = hard_link_count(file)

i = [];
if stdlib.strempty(file)
  return
end

try
  opt = javaMethod('values', 'java.nio.file.LinkOption');
  p = javaAbsolutePath(file);
  i = javaMethod('getAttribute', 'java.nio.file.Files', p, 'unix:nlink', opt);
  % i = java.nio.file.Files.getAttribute(javaAbsolutePath(file), "unix:nlink", java.nio.file.LinkOption.values());
catch e
  javaException(e)
end

end
