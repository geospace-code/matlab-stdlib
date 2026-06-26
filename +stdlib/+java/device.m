function i = device(file)

i = missing;

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
  i = uint64(i);
catch e
  javaException(e);
end

end
