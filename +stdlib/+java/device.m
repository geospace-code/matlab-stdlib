function i = device(file)
arguments
  file (1,1) string
end

i = uint64([]);
if ~stdlib.exists(file), return, end

opt = java.nio.file.LinkOption.values();

jp = javaPathObject(stdlib.absolute(file));
% Java 1.8 benefits from the absolute() for stability
% seen on older Matlab versions on HPC

try %#ok<TRYNC>
  i = java.nio.file.Files.getAttribute(jp, 'unix:dev', opt);
end

i = uint64(i);
end
