function i = hard_link_count(file)

opt = java.nio.file.LinkOption.values();
try
  i = java.nio.file.Files.getAttribute(javaAbsolutePath(file), "unix:nlink", opt);
catch e
  javaException(e)
  i = [];
end
end
