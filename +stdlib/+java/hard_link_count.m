function i = hard_link_count(file)


i = [];
if stdlib.strempty(file)
  return
end

try
  i = java.nio.file.Files.getAttribute(javaAbsolutePath(file), "unix:nlink", java.nio.file.LinkOption.values());
catch e
  javaException(e)
end

end
