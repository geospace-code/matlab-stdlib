function c = hard_link_count(p)

opt = javaMethod("values", "java.nio.file.LinkOption");
c = java.nio.file.Files.getAttribute(javaPathObject(p), "unix:nlink", opt);

end