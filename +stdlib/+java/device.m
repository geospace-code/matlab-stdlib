function i = device(file)

i = uint64([]);

if stdlib.strempty(file)
  return
end

% Java 1.8 benefits from the absolute() for stability
% seen on older Matlab versions on HPC

try
  opt = javaMethod('values', 'java.nio.file.LinkOption');
  p = javaAbsolutePath(file);
  i = javaMethod('getAttribute', 'java.nio.file.Files', p, 'unix:dev', opt);
  % i = java.nio.file.Files.getAttribute(javaAbsolutePath(file), "unix:dev", opt);
catch e
  javaException(e)
end

i = uint64(i);
end
