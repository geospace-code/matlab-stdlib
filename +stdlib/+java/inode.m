function i = inode(file)

opt = java.nio.file.LinkOption.values();

jp = javaPathObject(stdlib.absolute(file));
% Java 1.8 benefits from the absolute() for stability--it's not an issue
% on every computer.

try
  i = java.nio.file.Files.getAttribute(jp, "unix:ino", opt);
catch
  i = [];
end

i = uint64(i);
end
