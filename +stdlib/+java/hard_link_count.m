function i = hard_link_count(file)

opt = java.nio.file.LinkOption.values();
try
  i = java.nio.file.Files.getAttribute(javaAbsolutePath(file), "unix:nlink", opt);
catch e
  if class(e.ExceptionObject) ~= "java.nio.file.NoSuchFileException"
    rethrow(e)
  end
  i = [];
end
end
