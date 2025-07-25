function i = device(p)

opt = javaMethod("values", "java.nio.file.LinkOption");
i = java.nio.file.Files.getAttribute(javaPathObject(p), "unix:dev", opt);

end
