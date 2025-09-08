function i = hard_link_count(file)

try
  i = java.nio.file.Files.getAttribute(javaAbsolutePath(file), "unix:nlink", java.nio.file.LinkOption.values());
catch e
  javaException(e)
  i = [];
end
end
