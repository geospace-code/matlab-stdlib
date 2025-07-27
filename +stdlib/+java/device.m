function i = device(p)

opt = javaMethod("values", "java.nio.file.LinkOption");
i = javaMethod("getAttribute", "java.nio.file.Files", javaPathObject(p), "unix:dev", opt);

end
