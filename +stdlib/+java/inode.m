function i = inode(p)

opt = javaMethod("values", "java.nio.file.LinkOption");
i = javaMethod("getAttribute", "java.nio.file.Files", javaPathObject(p), "unix:ino", opt);

i = uint64(i);
end
