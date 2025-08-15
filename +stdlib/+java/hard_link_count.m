function c = hard_link_count(file)
arguments
  file (1,1) string
end

opt = java.nio.file.LinkOption.values();
try
  c = java.nio.file.Files.getAttribute(javaPathObject(file), "unix:nlink", opt);
catch
  c = [];
end
end
