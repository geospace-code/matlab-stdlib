function i = inode(p)

opt = java.nio.file.LinkOption.values();

jp = javaPathObject(stdlib.absolute(p));
% Java 1.8 benefits from the absolute() for stability--it's not an issue
% on every computer.

i = java.nio.file.Files.getAttribute(jp, "unix:ino", opt);

i = uint64(i);
end
