function isreg = is_regular_file(p)
arguments
  p (1,1) string
end

opt = java.nio.file.LinkOption.values;

% not correct without canonical(). Normalize() doesn't help.
p = stdlib.canonical(p);

isreg = java.nio.file.Files.isRegularFile(java.io.File(p).toPath(), opt);

end