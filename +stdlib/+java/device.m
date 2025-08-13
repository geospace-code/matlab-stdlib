function i = device(file)

opt = java.nio.file.LinkOption.values();
p = javaPathObject(file);
i = java.nio.file.Files.getAttribute(p, 'unix:dev', opt);

i = uint64(i);
end
