function isreg = is_regular_file(p)
arguments
  p (1,1) string
end

opt = java.nio.file.LinkOption.values;

% needs absolute()
p = stdlib.absolute(p);

isreg = java.nio.file.Files.isRegularFile(java.io.File(p).toPath(), opt);

end