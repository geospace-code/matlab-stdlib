function c = hard_link_count(p)

opt = java.nio.file.LinkOption.values();
try
  c = java.nio.file.Files.getAttribute(javaPathObject(p), "unix:nlink", opt);
catch
  c = [];
end
end
