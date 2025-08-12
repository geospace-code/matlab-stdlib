function i = device(file)

opt = javaMethod("values", "java.nio.file.LinkOption");
p = javaPathObject(file);
i = java.nio.file.Files.getAttribute(p, "unix:dev", opt);

i = uint64(i);
end
