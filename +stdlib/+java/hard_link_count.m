function c = hard_link_count(p)

opt = java.nio.file.LinkOption.values();
c = java.nio.file.Files.getAttribute(javaPathObject(p), "unix:nlink", opt);

end