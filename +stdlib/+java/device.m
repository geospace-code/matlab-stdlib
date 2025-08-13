function i = device(file)

opt = java.nio.file.LinkOption.values();

jp = javaPathObject(stdlib.absolute(file));
% Java 1.8 benefits from the absolute() for stability
% seen on older Matlab versions on HPC

i = java.nio.file.Files.getAttribute(jp, 'unix:dev', opt);

i = uint64(i);
end
