function i = inode(p)

opt = javaMethod("values", "java.nio.file.LinkOption");

jp = javaPathObject(stdlib.absolute(p));
% Java 1.8 benefits from the absolute() for stability--it's not an issue
% on every computer.

i = javaMethod("getAttribute", "java.nio.file.Files", jp, "unix:ino", opt);

i = uint64(i);
end
