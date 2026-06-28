function i = device(file)

% Java 1.8 benefits from the absolute() for stability
% seen on older Matlab versions on HPC

if ~ispc() && stdlib.has_java()
  opt = javaMethod('values', 'java.nio.file.LinkOption');
  p = javaAbsolutePath(file);
  i = javaMethod('getAttribute', 'java.nio.file.Files', p, 'unix:dev', opt);
  % i = java.nio.file.Files.getAttribute(javaAbsolutePath(file), "unix:dev", opt);
  i = uint64(i);
else 
  i = missing;
end

end
