function isabs = is_absolute(p)
arguments
  p (1,1) string
end

isabs = java.io.File(p).toPath().isAbsolute();

% alternative
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#isAbsolute()
end
