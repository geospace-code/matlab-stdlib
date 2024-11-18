%% IS_REGULAR_FILE check if path is a regular file

function isreg = is_regular_file(p)
arguments
  p (1,1) string
end

opt = java.nio.file.LinkOption.values;

% needs absolute()
p = stdlib.absolute(p, string.empty, false, true);

isreg = java.nio.file.Files.isRegularFile(java.io.File(p).toPath(), opt);

end
