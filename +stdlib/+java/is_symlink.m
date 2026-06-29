function y = is_symlink(file)

if stdlib.has_java()
  p = javaAbsolutePath(file);
  y = javaMethod('isSymbolicLink', 'java.nio.file.Files', p);
else
  y = missing;
end

end
