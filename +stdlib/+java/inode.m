function i = inode(file)

i = uint64([]);

if stdlib.strempty(file)
  return
end

% Java 1.8 benefits from the absolute() for stability
% seen on older Matlab versions on HPC
opt = java.nio.file.LinkOption.values();

try
  i = java.nio.file.Files.getAttribute(javaAbsolutePath(file), "unix:ino", opt);
catch e
  if class(e.ExceptionObject) ~= "java.nio.file.NoSuchFileException"
    rethrow(e)
  end
end

i = uint64(i);
end
